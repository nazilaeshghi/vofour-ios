//
//  DataEntryDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class DataEntryDataModel {
    private (set) var taskID: String?
    private (set) var contextId: String?
    private (set) var isActivity: Bool = true
    private (set) var activityTitle: String?
    private (set) var prevention: String?
    private (set) var reason: String?
    private (set) var completionMotivations: String?
    private (set) var goalID: String?
    private (set) var isRepeatable: Bool?
    private (set) var startDate: Date? = Date().getSimpleDate()
    private (set) var endDate: Date?
    private (set) var duration: Double?
    private (set) var color: String?
    private (set) var numberOfRepeat: Int?
    private (set) var days: [WeekDayObject]?
    private (set) var reminders: [TimeObject] = []
    
    func updateContextId(id: String) {
        self.contextId = id
    }
    
    func updateTaskId(id: String) {
        self.taskID = id
    }
    
    func updateIsActivity(with value: Bool) {
        self.isActivity = value
    }
    
    func updateTitle(with value: String) {
        activityTitle = value
    }
    
    func updatePrevention(with value: String?) {
        prevention = value
    }
    
    func updateReason(with value: String?) {
        reason = value
    }
    
    func updateCompletionMotivations(with value: String?) {
        completionMotivations = value
    }
    
    func updateGoalID(with value: String?) {
        goalID = value
    }
    
    func updateIsRepeatable(with value: Bool) {
        isRepeatable = value
    }
    
    func updateStartDate(with value: Date?) {
        startDate = value
    }
    
    func updateEndDate(with value: Date?) {
        endDate = value
    }
    
    func updateduration(with value: Double?) {
        duration = value
    }
    
    func updateWeekDays(with value: [WeekDayObject]) {
        days = value
    }
    
    func updateWeekDays(with value: String) {
        let splitedDays = value.components(separatedBy: ",")
        var builtWeekDays = DateBuilder.buildWeekDays()
        for day in builtWeekDays {
            if !splitedDays.contains(day.id) {
                builtWeekDays[day.index].selected = false
            }
        }
        updateWeekDays(with: builtWeekDays)
    }
    
    func updateNumberOfRepeat(with value: Int) {
        numberOfRepeat = value
    }
    
    func updateColor(with value: String) {
        color = value
    }
    
    func updateReminders(reminders: [TimeObject]) {
        self.reminders = reminders
    }
    
    func updateReminders(with value: String) {
        let splitedTimes = value.components(separatedBy: ",")
        var reminderTimes: [TimeObject] = []
        for time in splitedTimes {
            if let hourStr = time.components(separatedBy: ":").first,
               let minuteStr = time.components(separatedBy: ":").last,
               let hour = Int(hourStr),
               let minute = Int(minuteStr)
            {
                reminderTimes.append(TimeObject(id: UUID().uuidString, hour: hour, minute: minute))
            }
        }
        updateReminders(reminders: reminderTimes)
    }
}

extension DataEntryDataModel {
    convenience init(task: TaskDataModel) {
        self.init()
        updateTaskId(id: task.taskID)
        updateContextId(id: task.contextId)
        updateTitle(with: task.title)
        updateIsActivity(with: task.isActivity)
        updateGoalID(with: task.goalId)
        updatePrevention(with: task.prevention)
        updateReason(with: task.reason)
        updateCompletionMotivations(with: task.completionMotivations)
        updateColor(with: task.color)
        updateWeekDays(with: task.weekDays)
        updateStartDate(with: task.startDate)
        updateEndDate(with: task.endDate)
        updateIsRepeatable(with: task.isRepeatable)
        updateNumberOfRepeat(with: task.numberOfRepeat)
        updateduration(with: task.duration)
        updateReminders(with: task.reminders)
    }
}

struct RecordEntry: Record {
    var recordID: String
    var taskID: String
    var date: Date
    var count: Int
    var total: Int
}
