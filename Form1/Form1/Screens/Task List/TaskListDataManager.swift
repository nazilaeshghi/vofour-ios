//
//  TodayDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskListDataManagable {
    func fetchTasks(date: Date) -> [DailyTaskDataModel]
    func increamentTask(taskID: String, date: Date)
}

class TaskListDataManager: TaskListDataManagable {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchTasks(date: Date) -> [DailyTaskDataModel] {
        guard let changedDate = date.getSimpleDate() else { return [] }
        let dayID = date.getWeekDayID()
        return dataManager.fetchTaks(weekDay: dayID, date: changedDate)
    }
    
    func increamentTask(taskID: String, date: Date) {
        if let rcord = dataManager.fetchRecord(taskID: taskID, date: date) {
            dataManager.updateRecord(recordID: rcord.recordID, count: rcord.count + 1)
        }
        else {
            guard let task = dataManager.fetchTask(taskID: taskID) else { return }
            let record = RecordEntry(recordID: UUID().uuidString,
                                     taskID: taskID,
                                     date: date,
                                     count: 1,
                                     total: task.numberOfRepeat)
            dataManager.saveRecord(record: record)
        }
    }

}
