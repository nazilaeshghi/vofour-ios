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
    func fetchContext(id: String) -> TaskContext?
    func fetchGoal(id: String) -> Goal?
    func increment()
    func decrement()
    func deleteTask()
}

class TaskDetailDataManager: TaskDetailDataManagable {
    private let taskID: String
    private let currentDate: Date
    @Injected(\.dataManagerProvider) internal var dataManager: DataManager

    init(taskID: String, currentDate: Date) {
        self.taskID = taskID
        self.currentDate = currentDate
    }
    
    func fetchTaskDetail() -> DailyTaskDataModel? {
        guard let task = dataManager.fetchTask(taskID: taskID) else { return nil }
        let record = dataManager.fetchRecord(taskID: taskID, date: currentDate)
        return DailyTaskDataModel(task: task, record: record)
    }
    
    func fetchContext(id: String) -> TaskContext? {
        return dataManager.context(id: id)
    }
    
    func fetchGoal(id: String) -> Goal? {
        return dataManager.findGoal(with: id)
    }
    
    func increment() {
        dataManager.updateRecord(taskID: taskID, date: currentDate, increment: true)
    }
    
    func decrement() {
        dataManager.updateRecord(taskID: taskID, date: currentDate, increment: false)
    }
    
    func deleteTask() {
        dataManager.deleteTask(id: taskID)
    }
}
