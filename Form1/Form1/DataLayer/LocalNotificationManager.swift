//
//  LocalNotificationManager.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-12.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation
import NotificationCenter

protocol NotificationManagable {
    func requestAuthorization() async throws
    func getCurrentSettings() async
    func openSettings() async
    func scheduleNotifications(taskId: String, task: DataEntryDataModel)
    func removeScheduleNotifications(taskId: String)
}

class LocalNotificationManager: NSObject, NotificationManagable, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    var isGranted = false
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    // Delegate function
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.sound, .banner]
    }
    
    func requestAuthorization() async throws {
        try await notificationCenter
            .requestAuthorization(options: [.sound, .badge, .alert])
        await getCurrentSettings()
    }
    
    func getCurrentSettings() async {
        let currentSettings = await notificationCenter.notificationSettings()
        isGranted = (currentSettings.authorizationStatus == .authorized)
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                Task {
                    await UIApplication.shared.open(url)
                }
            }
        }
    }
    
    func clearAllRequests() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
    
    func removeScheduleNotifications(taskId: String) {
        let prefixNotificationID = taskId + "_notification_date"
        notificationCenter.getPendingNotificationRequests { [weak self] (notifications) in
            let foundNotifications = notifications.filter{ $0.identifier.hasPrefix(prefixNotificationID) }.map{ $0.identifier}
            self?.notificationCenter.removeDeliveredNotifications(withIdentifiers: foundNotifications)
            self?.notificationCenter.removePendingNotificationRequests(withIdentifiers: foundNotifications)
        }
    }
    
    func scheduleNotifications(taskId: String, task: DataEntryDataModel) {
        var requests = [UNNotificationRequest]()
        let formatter = DateHelper.generalDateFormatterWithDefaultCalendar()

        if let startDate = task.startDate,
           let endDate = task.endDate,
           !task.reminders.isEmpty,
           let weekDays = task.days
        {
            let dates = DateHelper().getDatesBetween(startDate: startDate, endDate: endDate, weekDays: weekDays)
            for (dateIndex, date) in dates.enumerated() {
                for (index, reminder) in task.reminders.enumerated() {
                                        
                    var dateComponents = DateComponents()
                    dateComponents.year = date.year
                    dateComponents.month = date.month
                    dateComponents.day = date.day
                    dateComponents.hour = reminder.hour
                    dateComponents.minute = reminder.minute
                    
                    let trigger = UNCalendarNotificationTrigger(
                        dateMatching: dateComponents,
                        repeats: false)
                    
                    let content = UNMutableNotificationContent()
                    content.title = LocalizedString.Reminder.title
                    content.body = task.activityTitle ?? ""
                    
                    
                    let uuidString = taskId + "_notification" + "_date" + String(dateIndex) + "_reminder_" + String(index)
                    let request = UNNotificationRequest(identifier: uuidString,
                                                        content: content,
                                                        trigger: trigger)
                    requests.append(request)
                }
            }
        }
        
        else if let startDate = task.startDate,
                task.endDate == nil,
                !task.reminders.isEmpty
        {
            for (index, reminder) in task.reminders.enumerated() {
                var dateComponents = DateComponents()
                dateComponents.year = startDate.year
                dateComponents.month = startDate.month
                dateComponents.day = startDate.day
                dateComponents.hour = reminder.hour
                dateComponents.minute = reminder.minute
                
                let trigger = UNCalendarNotificationTrigger(
                    dateMatching: dateComponents,
                    repeats: false)
                
                let content = UNMutableNotificationContent()
                content.title = LocalizedString.Reminder.title
                content.body = task.activityTitle ?? ""
                
                
                let uuidString = taskId + "_notification" + "_date0" + "_reminder" + String(index)
                let request = UNNotificationRequest(identifier: uuidString,
                                                    content: content,
                                                    trigger: trigger)
                requests.append(request)
            }
        }
        
        for request in requests {
            notificationCenter.add(request) { (error) in
                if error != nil {}
            }
        }
    }
}
