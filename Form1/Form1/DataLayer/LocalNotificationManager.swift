//
//  LocalNotificationManager.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-12.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation
import NotificationCenter

enum NotificationState {
    case on
    case off
    case notGranted
    
    var localizedString: String {
        switch self {
        case .on:
            return LocalizedString.Setting.notificationEnabled
        case .off:
            return LocalizedString.Setting.notificationEnabled
        case .notGranted:
            return LocalizedString.Setting.notificationNotGranted
        }
    }
}

protocol NotificationManagable {
    func requestAuthorization() async throws
    func getCurrentSettings() -> Task<Void, Never>
    func openSettings() async
    func scheduleNotifications(taskId: String, task: DataEntryDataModel)
    func removeAndScheduleNotifications(taskId: String, task: DataEntryDataModel)
    func getNotificationState() -> NotificationState
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
        getCurrentSettings()
    }
    
    @discardableResult
    func getCurrentSettings() -> Task<Void, Never>  {
        return Task {
            let currentSettings = await notificationCenter.notificationSettings()
            isGranted = (currentSettings.authorizationStatus == .authorized)
        }
    }
    
    func getNotificationState() -> NotificationState {
        getCurrentSettings()
        guard !isGranted else { return .notGranted }
        return SettingHelper.isNotificationON() ? .on : .off
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
    
    func removeAndScheduleNotifications(taskId: String, task: DataEntryDataModel) {
        let prefixNotificationID = taskId + "_notification_date"
        notificationCenter.getPendingNotificationRequests { [weak self] (notifications) in
            let foundNotifications = notifications.filter{ $0.identifier.hasPrefix(prefixNotificationID) }.map{ $0.identifier }
            self?.notificationCenter.removeDeliveredNotifications(withIdentifiers: foundNotifications)
            self?.notificationCenter.removePendingNotificationRequests(withIdentifiers: foundNotifications)
            self?.scheduleNotifications(taskId: taskId, task: task)
        }
    }
    
    func scheduleNotifications(taskId: String, task: DataEntryDataModel) {
        var requests = [UNNotificationRequest]()

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
                    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "reminder.wav"))
                    
                    
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
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "reminder.wav"))
                
                
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
