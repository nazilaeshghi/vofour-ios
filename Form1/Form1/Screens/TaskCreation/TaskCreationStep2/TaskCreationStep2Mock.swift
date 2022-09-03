//
//  TaskCreationStep2Mock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskCreationStep2DataManagableMock: TaskCreationStep2DataManagable {
    var dataManager: DataManager = DataManager(dataProvider: MockDataProvider())
    
    func getContextName() -> String { "" }
    func isTaskActivity() -> Bool { return true }
    func updateTaskType(isRepeatable: Bool) {}
    func deleteReminders() {}
    func updateReminder(intervals: [TimeObject]) {}
    func updateStartDate(date: Date?) {}
    func updatEndDate(date: Date?) {}
    func updatDuration(interval: TimeInterval) {}
    func updateWeekDays(days: [WeekDayObject]) {}
    func updateNumberOfRepeat(int: Int) {}
    func updateColor(hex: String) {}
    func saveTask() {}
}
