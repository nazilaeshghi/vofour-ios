//
//  TaskDetailDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskDetailDataManagable {
    func fetchTaskDetail() -> DailyTaskDataModel?
    func increment()
    func decrement()
}

class TaskDetailDataManager: TaskDetailDataManagable {
    private let taskID: String
    private let currentDate: Date
    private let dataManager: DataManager

    init(taskID: String, currentDate: Date, dataManager: DataManager) {
        self.dataManager = dataManager
        self.taskID = taskID
        self.currentDate = currentDate
    }
    
    func fetchTaskDetail() -> DailyTaskDataModel? {
        guard let task = dataManager.fetchTask(taskID: taskID) else { return nil }
        let record = dataManager.fetchRecord(taskID: taskID, date: currentDate)
        return DailyTaskDataModel(task: task, record: record)
    }
    
    func increment() {
        if let rcord = dataManager.fetchRecord(taskID: taskID, date: currentDate) {
            dataManager.updateRecord(recordID: rcord.recordID, count: rcord.count + 1)
        }
        else {
            guard let task = dataManager.fetchTask(taskID: taskID) else { return }
            let record = RecordEntry(recordID: UUID().uuidString,
                                     taskID: taskID,
                                     date: currentDate,
                                     count: 1,
                                     total: task.numberOfRepeat)
            dataManager.saveRecord(record: record)
        }
    }
    
    func decrement() {
        if let rcord = dataManager.fetchRecord(taskID: taskID, date: currentDate) {
            dataManager.updateRecord(recordID: rcord.recordID, count: rcord.count - 1)
        }
    }
}
