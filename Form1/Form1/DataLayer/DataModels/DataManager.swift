//
//  DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class DataManager {
    @Injected(\.localNotificationProvider) var notificationProvider: NotificationManagable

    private let dataProvider: DataProvider
    private(set) var currentInputEntry: DataEntryDataModel = DataEntryDataModel()
    
    init(dataProvider: DataProvider)  {
        self.dataProvider = dataProvider
        askForNotificationAccess()
    }
    
    @discardableResult
    func askForNotificationAccess() -> Task <Void, Never>{
        return Task {
            do {
                try await notificationProvider.requestAuthorization()
            } catch {}
        }
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
        let entity = GoalEntity(id: id, title: title.trimmingCharacters(in: .whitespacesAndNewlines))
        dataProvider.createGoal(newEntity: entity)
        currentInputEntry.updateGoalID(with: id)
        return id
    }
    
    func findGoal(with id: String) -> Goal? {
        return dataProvider.findGoal(with: id)
    }
    
    func findGoal(title: String) -> Goal? {
        return dataProvider.findGoal(title: title)
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
            let record: RecordEntry
            if increment {
                record = RecordEntry(recordID: UUID().uuidString,
                                     taskID: taskID,
                                     date: simpleDate,
                                     count: 1,
                                     total: task.numberOfRepeat)
            } else {
                record = RecordEntry(recordID: UUID().uuidString,
                                     taskID: taskID,
                                     date: simpleDate,
                                     count: 0,
                                     total: task.numberOfRepeat)
            }
            saveRecord(record: record)
        }
    }
    
    func computeDayProgress(date: Date) -> Float {
        let simpleDate = date.getSimpleDate()
        let weekDay = simpleDate.getWeekDayID()

        let dayTasks = dataProvider.fetchTasks(for: weekDay, date: simpleDate)
        guard dayTasks.count > 0 else { return -1.0 }
        
        let sum = dayTasks.map { $0.progress }.reduce(0, +)
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
        fixStringsBeforeSaving()
        let id = dataProvider.saveTask(entry: currentInputEntry)
        if let taskId = id {
            dataProvider.updateRecord(taskID: taskId, total: currentInputEntry.numberOfRepeat ?? 0)
            DateHelper.setDateRegion()
            notificationProvider.removeAndScheduleNotifications(taskId: taskId, task: currentInputEntry)
        }
        resetDataEntry()
    }
    
    func fixStringsBeforeSaving() {
        let fixedTitle = currentInputEntry.activityTitle?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        currentInputEntry.updateTitle(with: fixedTitle)
        
        if let reason = currentInputEntry.reason {
            let fixedReason = reason.trimmingCharacters(in: .whitespacesAndNewlines)
            currentInputEntry.updateReason(with: fixedReason)
        }
        
        if let for100 = currentInputEntry.completionMotivations {
            let fixedFor100 = for100.trimmingCharacters(in: .whitespacesAndNewlines)
            currentInputEntry.updateCompletionMotivations(with: fixedFor100)
        }
        
        if let prevention = currentInputEntry.prevention {
            let fixedprevention = prevention.trimmingCharacters(in: .whitespacesAndNewlines)
            currentInputEntry.updatePrevention(with: fixedprevention)
        }
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
    
    
    func fetchCurrentWeekGoalTasks(goalId: String) -> ActivityGoalDataModel? {
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

        guard let goal = dataProvider.findGoal(with: goalId) else { return nil }
        
        // Find current week days
        let todayDate = Date().getSimpleDate()
        let weekDays = DateBuilder.make7Days(selectedDate: todayDate)
        var goalProgressDict = [String: (progress: Float, total: Int)]()
        
        // Fetch tasks for eveyday in current week
        var tempTask = Set<HashableTask>()
        for day in weekDays {
            let goalDayTasks = dataProvider.fetchTasks(for: day.obj.id, date: day.date, goalId: goalId)
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
                
        return ActivityGoalDataModel(goal: goal,
                                     tasks: Array(tempTask))
        
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
    
    func fetchGoalTasks(goalId: String) -> ActivityGoalDataModel? {
        guard let goal = dataProvider.findGoal(with: goalId) else { return nil }
        
        let goalTasks: [HashableTask] = dataProvider.fetchTasks(for: goal.id).compactMap { task in
            guard let context = dataProvider.findContext(id: task.contextId) else {
                return nil
            }
            return HashableTask(task: task, progress: 0, context: context)
        }
        guard goalTasks.count > 0 else { return nil }
        return ActivityGoalDataModel(goal: goal,
                                     tasks: goalTasks)
    }
}
