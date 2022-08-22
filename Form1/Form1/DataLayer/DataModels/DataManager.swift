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
    private func saveRecord(record: Record) {
        dataProvider.saveRecord(record: record)
    }
    
    private func updateRecord(recordID: String, count: Int) {
        dataProvider.updateRecord(recordID: recordID, count: count)
    }
    
    func updateRecord(taskID: String, date: Date, increment: Bool) {
        let simpleDate = date.getSimpleDate()
        if let rcord = fetchRecord(taskID: taskID, date: simpleDate) {
            if increment {
                updateRecord(recordID: rcord.recordID, count: rcord.count + 1)
            } else {
                guard (rcord.count - 1) >= 0 else { return }
                updateRecord(recordID: rcord.recordID, count: rcord.count - 1)
            }
        }
        else {
            guard let task = fetchTask(taskID: taskID) else { return }
            let record = RecordEntry(recordID: UUID().uuidString,
                                     taskID: taskID,
                                     date: simpleDate,
                                     count: 1,
                                     total: task.numberOfRepeat)
            saveRecord(record: record)
        }
    }
    
    func fetchTaks(date: Date) -> [DailyTaskDataModel] {
        let simpleDate = date.getSimpleDate()
        let dayID = simpleDate.getWeekDayID()
        return dataProvider.fetchTaks(weekDay: dayID, date: simpleDate)
    }
    
    func computeDayProgress(date: Date) -> Float {
        let simpleDate = date.getSimpleDate()
        let weekDay = simpleDate.getWeekDayID()

        let dayTasks = dataProvider.fetchTaks(weekDay: weekDay, date: simpleDate)
        guard dayTasks.count > 0 else { return 1.0 }
        
        let sum = dayTasks.map { model -> Float in
            if (model.record?.total ?? 0) == 0 {
                return 0
            }
            else {
                let dayCalculate = Float(model.record?.count ?? 0) / Float(model.record?.total ?? 0)
                return dayCalculate > 1.0 ? 1.0 : dayCalculate
            }
        }.reduce(0, +)
        var dayProgress = sum / Float(dayTasks.count)
        if dayProgress.isNaN { dayProgress = 0 }
        if dayProgress > 1.0  { dayProgress = 1.0 }
        return dayProgress
    }
    
    func computeWeekProgress() -> Float {
        let totoalProgresses = DateBuilder.make7Days(selectedDate: Date()).map {
            return computeDayProgress(date: $0.date)
        }
        let notNanProsesses = totoalProgresses
            .filter { !$0.isNaN }
        
        let totalProgress = notNanProsesses.reduce(0, +)
        let wekkProgress = totalProgress / Float(notNanProsesses.count)
        guard !wekkProgress.isNaN else { return 0 }
        return wekkProgress > 1.0 ? 1.0 : wekkProgress
    }
    
    func fetchRecord(taskID: String, date: Date) -> Record? {
        let simpleDate = date.getSimpleDate()
        return dataProvider.fetchRecord(taskID: taskID, date: simpleDate)
    }

}
