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
    
    func resetDataEntry(){
        currentInputEntry = DataEntryDataModel()
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
    
    func saveDefaultGoal() {
        guard dataProvider.findGoal(with: "-1") == nil else { return }
        let id = "-1"
        let entity = GoalEntity(id: id, title: LocalizedString.SelectGoalPage.defaultGoalTitle)
        return dataProvider.createGoal(newEntity: entity)
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
        
    // MARK: - Record
    private func saveRecord(record: Record) {
        dataProvider.saveRecord(record: record)
    }
    
    private func updateRecord(recordID: String, count: Int) {
        dataProvider.updateRecord(recordID: recordID, count: count)
    }
    
    func updateRecord(taskID: String, date: Date, increment: Bool) {
        let simpleDate = date.getSimpleDate()
        if let record = fetchRecord(taskID: taskID, date: simpleDate) {
            if increment {
                updateRecord(recordID: record.recordID, count: record.count + 1)
            } else {
                guard (record.count - 1) >= 0 else { return }
                updateRecord(recordID: record.recordID, count: record.count - 1)
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
    
    func computeDayProgress(date: Date) -> Float {
        let simpleDate = date.getSimpleDate()
        let weekDay = simpleDate.getWeekDayID()

        let dayTasks = dataProvider.fetchTasks(for: weekDay, date: simpleDate)
        guard dayTasks.count > 0 else { return -1.0 }
        
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
    
    func computeWeekProgress(selectedDate: Date) -> Float {
        let totoalProgresses = DateBuilder.make7Days(selectedDate: selectedDate).map {
            return computeDayProgress(date: $0.date)
        }
        let notNanProsesses = totoalProgresses
            .filter { !$0.isNaN && $0 >= 0 }
        
        guard !notNanProsesses.isEmpty else { return -1.0 }
        
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

extension DataManager {
    func startEditTask(taskId: String) {
        guard let task = fetchTask(taskID: taskId) else { return }
        currentInputEntry = DataEntryDataModel(task: task)
    }
}

// MARK: - Task
extension DataManager {
    func fetchTask(taskID: String) -> TaskDataModel? {
        return dataProvider.fetchTask(id: taskID)
    }
    
    func saveTask() {
        dataProvider.saveTask(entry: currentInputEntry)
        resetDataEntry()
    }
    
    func deleteTask(id: String) {
        dataProvider.deleteTask(id: id)
    }
    
    func fetchTaskCount(for contextID: String) -> Int {
        return dataProvider.fetchTaskCount(for: contextID)
    }
    
    func fetchDailyTasks(for date: Date) -> [DailyTaskDataModel] {
        let simpleDate = date.getSimpleDate()
        let dayID = simpleDate.getWeekDayID()
        return dataProvider.fetchTasks(for: dayID, date: simpleDate)
    }
    
    func fetchCurrentWeekGoalsTasks() -> [ActivityGoalDataModel] {
        func calculateTaskProgress(record: Record?) -> Float {
            guard let record = record else { return 0.0 }
            guard record.count > 0 else { return 0.0 }
            guard record.total > 0 else { return 0.0 }
            let dayCalculate = Float(record.count) / Float( record.total)
            return dayCalculate > 1.0 ? 1.0 : dayCalculate
        }
        
        func fillTaskProgressDict(for taskWithRecord: DailyTaskDataModel) {
            if goalProgressDict[taskWithRecord.task.taskID] == nil {
                goalProgressDict[taskWithRecord.task.taskID]  = (calculateTaskProgress(record: taskWithRecord.record), 1)
            }
            else {
                let currentTotal = goalProgressDict[taskWithRecord.task.taskID]?.total ?? 0
                let newTotal = (goalProgressDict[taskWithRecord.task.taskID]?.total ?? 0) + 1
                
                let currentProgress = Float((goalProgressDict[taskWithRecord.task.taskID]?.progress ?? 0)) * Float(currentTotal)
                let addedProgress = calculateTaskProgress(record: taskWithRecord.record)
                let newProgress = (currentProgress + addedProgress) / Float(newTotal)
                goalProgressDict[taskWithRecord.task.taskID] = (progress: newProgress, total: newTotal)
            }
        }
        
        // Find current week days
        let todayDate = Date().getSimpleDate()
        let weekDays = DateBuilder.make7Days(selectedDate: todayDate)
        var goalProgressDict = [String: (progress: Float, total: Int)]()
        
        // Fetch tasks for eveyday in current week
        var tempTask = Set<HashableTask>()
        for day in weekDays {
            let goalDayTasks = dataProvider.fetchTasks(for: day.obj.id, date: day.date)
            for taskWithRecord in goalDayTasks {
                guard let context = dataProvider.findContext(id: taskWithRecord.task.contextId) else {
                    continue
                }
                fillTaskProgressDict(for: taskWithRecord)
                let hTask = HashableTask(task: taskWithRecord.task,
                                         progress: goalProgressDict[taskWithRecord.task.taskID]?.progress ?? 0.0,
                                         context: context)
                tempTask.update(with: hTask)
            }
        }
        
        let grouped = Dictionary(grouping: tempTask, by: { $0.task.goalId })
        
        let output = grouped.compactMap { item -> ActivityGoalDataModel? in
            guard let goal = findGoal(with: item.key) else { return nil }
            return ActivityGoalDataModel(goal: goal,
                                         tasks: item.value)
            
        }
        
        return output
    }
    
    func fetchAllGoalsTasks() -> [ActivityGoalDataModel] {
        let goals = dataProvider.fetchGoals()
        
        var output = [ActivityGoalDataModel]()
        for goal in goals {
            let goalTasks: [HashableTask] = dataProvider.fetchTasks(for: goal.id).compactMap { task in
                guard let context = dataProvider.findContext(id: task.contextId) else {
                    return nil
                }
                return HashableTask(task: task, progress: 0, context: context)
            }
            guard goalTasks.count > 0 else { continue }
            output.append(ActivityGoalDataModel(goal: goal,
                                                tasks: goalTasks))
        }
        return output
    }
}
