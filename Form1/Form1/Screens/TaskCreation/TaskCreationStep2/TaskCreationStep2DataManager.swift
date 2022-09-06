//
//  TaskCreationStep2DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskCreationStep2DataManagable: BaseDataManagable {
    func getContextName() -> String
    func isTaskActivity() -> Bool
    
    func isRepeatableTask() -> Bool
    func updateTaskType(isRepeatable: Bool)
    
    func getReminder() -> [TimeObject]
    func deleteReminders()
    func updateReminder(intervals: [TimeObject])
    
    func getStartDate() -> Date?
    func updateStartDate(date: Date?)
    
    func getEndDate() -> Date?
    func updatEndDate(date: Date?)
    
    func getDuration() -> DurationObject?
    func updatDuration(interval: TimeInterval)
    
    func getWeekDays() -> [WeekDayObject]
    func updateWeekDays(days: [WeekDayObject])
    
    func getNumberOfRepeat() -> Int
    func updateNumberOfRepeat(int: Int)
    
    func getColor() -> String
    func updateColor(hex: String)
    
    func saveTask()
}

class TaskCreationStep2DataManager: TaskCreationStep2DataManagable {
    internal let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func getContextName() -> String{
        guard let contextId = dataManager.currentInputEntry.contextId else { return "" }
        return dataManager.context(id: contextId)?.name ?? ""
    }
    
    func isTaskActivity() -> Bool {
        return dataManager.currentInputEntry.isActivity
    }
    
    func isRepeatableTask() -> Bool {
        return dataManager.currentInputEntry.isRepeatable ?? false
    }
    func updateTaskType(isRepeatable: Bool) {
        dataManager.currentInputEntry.updateIsRepeatable(with: isRepeatable)
    }
    
    func deleteReminders() {
        dataManager.currentInputEntry.updateReminders(reminders: [])
    }
    func getReminder() -> [TimeObject]{
        return dataManager.currentInputEntry.reminders
    }
    func updateReminder(intervals: [TimeObject]) {
        dataManager.currentInputEntry.updateReminders(reminders: intervals)
    }
    
    func getStartDate() -> Date? {
        return dataManager.currentInputEntry.startDate
    }
    
    func updateStartDate(date: Date?) {
        dataManager.currentInputEntry.updateStartDate(with: date)
    }
    
    func getEndDate() -> Date? {
        return dataManager.currentInputEntry.endDate
    }
    
    func updatEndDate(date: Date?) {
        dataManager.currentInputEntry.updateEndDate(with: date)
    }
    
    func getDuration() -> DurationObject? {
        if let duration = dataManager.currentInputEntry.duration {
            return DurarionBuilder.makeDurations().first { $0.amount == duration }
        } else {
            return nil
        }
    }
    func updatDuration(interval: TimeInterval) {
        dataManager.currentInputEntry.updateduration(with: interval)
    }
    
    func getWeekDays() -> [WeekDayObject] {
        return dataManager.currentInputEntry.days ?? DateBuilder.buildWeekDays()
    }
    func updateWeekDays(days: [WeekDayObject]) {
        dataManager.currentInputEntry.updateWeekDays(with: days)
    }
    
    func getNumberOfRepeat() -> Int {
        return dataManager.currentInputEntry.numberOfRepeat ?? 1
    }
    func updateNumberOfRepeat(int: Int) {
        dataManager.currentInputEntry.updateNumberOfRepeat(with: int)
    }
    
    func getColor() -> String {
        return dataManager.currentInputEntry.color ?? "#EA4C89"
    }
    
    func updateColor(hex: String) {
        dataManager.currentInputEntry.updateColor(with: hex)
    }
    
    func saveTask() {
        dataManager.saveTask()
    }
}
