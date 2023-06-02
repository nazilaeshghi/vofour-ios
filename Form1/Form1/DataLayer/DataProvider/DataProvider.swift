//
//  DataProvider.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol DataProvider {
    func saveContexts()
    func findContext(id: String) -> TaskContext?
    func fetchContexts() -> [TaskContext]
    func fetchHomeContexts() -> [HomeContextDataModel]

    
    func fetchGoals() -> [Goal]
    func createGoal(newEntity: Goal)
    func findGoal(with id: String) -> Goal?
    
    func fetchTasks() -> [TaskDataModel]
    func saveTask(entry: DataEntryDataModel)
    func fetchTasks(for weekDay: String, date: Date) -> [DailyTaskDataModel]
    func fetchTasks(for weekDay: String, date: Date, goalId: String) -> [DailyTaskDataModel]
    func fetchTask(id: String) -> TaskDataModel?
    func deleteTask(id: String)
    func fetchTaskCount(for contextID: String) -> Int
    func fetchTasks(for goalID: String) -> [TaskDataModel]
    
    func saveRecord(record: Record)
    func fetchRecord(taskID: String, date: Date) -> Record?
    func fetchRecords(for taskID: String) -> [Record]
    func updateRecord(recordID: String, count: Int)
}

class MockDataProvider: DataProvider {
    func fetchTasks(for weekDay: String, date: Date, goalId: String) -> [DailyTaskDataModel] {
        return []
    }
    
    func fetchRecords(for taskID: String) -> [Record] {
        return []
    }
    
    func saveContexts() {
    }
    
    func findContext(id: String) -> TaskContext? {
        return nil
    }
    
    func fetchContexts() -> [TaskContext] {
        return []
    }
    
    func fetchHomeContexts() -> [HomeContextDataModel] {
        return []
    }
    
    func fetchGoals() -> [Goal] {
        return []
    }
    
    func createGoal(newEntity: Goal) {
        
    }
    
    func findGoal(with id: String) -> Goal? {
        return nil
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return []
    }
    
    func saveTask(entry: DataEntryDataModel) {
        
    }
    
    func fetchTasks(for weekDay: String, date: Date) -> [DailyTaskDataModel] {
        return []
    }
    
    func fetchAllTasks(for weekDay: String, date: Date) -> [TaskDataModel] {
        return []
    }
    
    func fetchTask(id: String) -> TaskDataModel? {
        return nil
    }
    
    func deleteTask(id: String) {
        
    }
    
    func fetchTaskCount(for contextID: String) -> Int {
        return 0
    }
    
    func fetchTasks(for goalID: String) -> [TaskDataModel] {
        []
    }
    
    func saveRecord(record: Record) {
        
    }
    
    func fetchRecord(taskID: String, date: Date) -> Record? {
        return nil
    }
    
    func updateRecord(recordID: String, count: Int) {
    }
    
    func fetchTasks(from startDate: Date, to endDate: Date) -> [TaskDataModel] {
        return []
    }
}
