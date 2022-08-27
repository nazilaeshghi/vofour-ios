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
    
    func addTask()
    func fetchTasks() -> [TaskDataModel]
    func saveTask(entry: DataEntryDataModel)
    func fetchTaks(weekDay: String, date: Date) -> [DailyTaskDataModel]
    func fetchTask(id: String) -> TaskDataModel?
    func deleteTask(id: String)
    func fetchTaskCount(for contextID: String) -> Int
    
    func saveRecord(record: Record)
    func fetchRecord(taskID: String, date: Date) -> Record?
    func updateRecord(recordID: String, count: Int)
}
