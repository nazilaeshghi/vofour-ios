//
//  DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class DataManager {
    private let dataProvider: DataProvider
    private(set) var currentInputEntry: DataEntryDataModel = DataEntryDataModel()
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Context
    func saveContexts() {
        dataProvider.saveContexts()
    }
    
    func fetchContexts() -> [TaskContext] {
        return dataProvider.fetchContexts()
    }
    
    func context(id: String) -> TaskContext? {
        return dataProvider.findContext(id: id)
    }
    
    func fetchAllHomeContexts() -> [HomeContextDataModel] {
        return dataProvider.fetchHomeContexts()
    }
    
    // MARK: - Goal
    func fetchGoals() -> [Goal] {
        return dataProvider.fetchGoals()
    }
    
    func createGoal(title: String) -> String {
        let id = UUID().uuidString
        let entity = GoalEntity(id: id, title: title)
        dataProvider.createGoal(newEntity: entity)
        currentInputEntry.updateGoalID(with: id)
        return id
    }
    
    func findGoal(with id: String) -> Goal? {
        return dataProvider.findGoal(with: id)
    }
    
    func findSelectedGoal() -> Goal? {
        guard let goalID = currentInputEntry.goalID else { return nil }
        return dataProvider.findGoal(with: goalID)
    }
    
    // MARK: - Task
    func fetchTask(taskID: String) -> TaskDataModel? {
        return dataProvider.fetchTask(id: taskID)
    }
    
    func saveTask() {
        dataProvider.saveTask(entry: currentInputEntry)
    }
    
    // MARK: - Record
    func saveRecord(record: Record) {
        dataProvider.saveRecord(record: record)
    }
    
    func updateRecord(recordID: String, count: Int) {
        dataProvider.updateRecord(recordID: recordID, count: count)
    }
    
    func fetchTaks(weekDay: String, date: Date) -> [DailyTaskDataModel] {
        return dataProvider.fetchTaks(weekDay: weekDay, date: date)
    }
    
    func computeDayProgress(weekDay: String, date: Date) -> Float {
        let dayTasks = dataProvider.fetchTaks(weekDay: weekDay, date: date)
        let sum = dayTasks.map { model -> Float in
            if (model.record?.total ?? 0) == 0 {
                return 0
            }
            else {
               return Float(model.record?.count ?? 0) / Float(model.record?.total ?? 0) }
            }.reduce(0, +)
        let dayProgress = sum / Float(dayTasks.count)
        return dayProgress > 1.0 ? 1.0 : dayProgress
    }
    
    func computeWeekProgress() -> Float {
        let totoalProgresses = DateBuilder.make7Days(selectedDate: Date()).map { obj -> Float in
            let dayID = obj.date.getWeekDayID()
            return computeDayProgress(weekDay: dayID, date: obj.date)
        }
        let notNanProsesses = totoalProgresses.filter { !$0.isNaN }
        let totalProgress = notNanProsesses.reduce(0, +)
        let wekkProgress = totalProgress / Float(notNanProsesses.count)
        return wekkProgress > 1.0 ? 1.0 : wekkProgress
    }
    
    func fetchRecord(taskID: String, date: Date) -> Record? {
        return dataProvider.fetchRecord(taskID: taskID, date: date)
    }

}
