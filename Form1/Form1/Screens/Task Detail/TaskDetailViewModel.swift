//
//  TaskDetailViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct TaskDetailAttribite: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
}

class TaskDetailViewModel: ObservableObject {
    private let dataManager: TaskDetailDataManagable
    
    let currentDate: Date
    var isDayMode: Bool
    
    @Published var item: CardDisplayModel!
    @Published var didFetchDate: Bool = false
    @Published var attributes: [TaskDetailAttribite] = []
    @Published var longAttributes: [TaskDetailAttribite] = []
    
    init(dataManager: TaskDetailDataManagable, currentDate: Date, isDayMode: Bool = false) {
        self.dataManager = dataManager
        self.currentDate = currentDate
        self.isDayMode = isDayMode
    }
    
    func fetchDetails() {
        guard let task = dataManager.fetchTaskDetail() else { return }
        item = WeekViewModel.transformDataModels(dayRecord: task)
        makeUI(task)
        didFetchDate = true
    }
    
    func makeUI(_ task: DailyTaskDataModel) {
        let subtitleStr = "از " + "\(task.task.numberOfRepeat)"
        item.subtitle = LabelDisplayModel(plainText: subtitleStr.convertToPersian(), style: .lightTitle)
        
        item.count.labelStyle = .regularGiantTitleStyle
        item.count.plainText =  item.count.plainText.convertToPersian()
        
        attributes = []
        longAttributes = []
        makeAttributes(task)
        makeLongAttributes(task)
    }
    
    func increment() {
        dataManager.increment()
        NotificationCenter.sendNotification(for: .dataChange)
    }
    
    func decrement() {
        dataManager.decrement()
        NotificationCenter.sendNotification(for: .dataChange)
    }
    
    func deleteTask() {
        dataManager.deleteTask()
        NotificationCenter.sendNotification(for: .dataChange)
    }
    
    func getWeekDays(with value: String) -> String {
        let splitedDays = value.components(separatedBy: ",")
        var builtWeekDays = DateBuilder.buildWeekDays()
        for day in builtWeekDays {
            if !splitedDays.contains(day.id) {
                builtWeekDays[day.index].selected = false
            }
        }
        return builtWeekDays
            .filter{ $0.selected }
            .map { $0.name }
            .joined(separator: "، ")
    }
    
    fileprivate func makeAttributes(_ task: DailyTaskDataModel) {
        let activityType = task.task.isActivity ? LocalizedString.TaskDetail.create : LocalizedString.TaskDetail.quit
        let activityAtt = TaskDetailAttribite(title: LocalizedString.TaskDetail.taskTypeTitle, value: activityType)
        attributes.append(activityAtt)
        
        let contextName = dataManager.fetchContext(id: task.task.contextId)?.name ?? ""
        let contextAtt = TaskDetailAttribite(title: LocalizedString.TaskDetail.contextTitle, value: contextName)
        attributes.append(contextAtt)
        
        let goalName = dataManager.fetchGoal(id: task.task.goalId)?.title ?? LocalizedString.TaskDetail.independent
        let goalAtt = TaskDetailAttribite(title: LocalizedString.TaskDetail.goalTitle, value: goalName)
        attributes.append(goalAtt)
        
        if let startDate = task.task.startDate {
            let startDate = DateHelper.fullDateFormatter().string(from: startDate)
            let att = TaskDetailAttribite(title: LocalizedString.Input.startDateSelectoreTitle, value: startDate)
            attributes.append(att)
        }
        
        if let endDate = task.task.endDate {
            let endDate = DateHelper.fullDateFormatter().string(from: endDate)
            let att = TaskDetailAttribite(title: LocalizedString.Input.endDateSelectoreTitle, value: endDate)
            attributes.append(att)
        }
        
        if let duration = task.task.duration?.timeStr {
            let att = TaskDetailAttribite(title: LocalizedString.Input.durationSelectoreTitle, value: duration)
            attributes.append(att)
        }
        
        if task.task.isRepeatable && task.task.isActivity  {
            let weekDays = getWeekDays(with: task.task.weekDays)
            let att = TaskDetailAttribite(title: LocalizedString.TaskDetail.weekDaysTitle, value: weekDays)
            attributes.append(att)
        }
        
        if (task.task.numberOfRepeat != 0) {
            let repeatTitleStr = task.task.isActivity ? LocalizedString.TaskDetail.repeatTitle : LocalizedString.TaskDetail.quitRepeatTitle
            let numberOfRepeat = String(task.task.numberOfRepeat).convertToPersian()
            let att = TaskDetailAttribite(title: repeatTitleStr, value: numberOfRepeat)
            attributes.append(att)
        }
    }
    
    fileprivate func makeLongAttributes(_ task: DailyTaskDataModel) {
        if let prevent = task.task.prevention, !prevent.isEmpty {
            let att = TaskDetailAttribite(title: LocalizedString.Input.obstacleHeader, value: prevent)
            longAttributes.append(att)
        }
        
        if let reason = task.task.reason, !reason.isEmpty {
            let att = TaskDetailAttribite(title: LocalizedString.Input.reasonTitle, value: reason)
            longAttributes.append(att)
            
        }
        
        if let for100 = task.task.completionMotivations, !for100.isEmpty {
            let att = TaskDetailAttribite(title: LocalizedString.TaskDetail.for100, value: for100)
            longAttributes.append(att)
        }
    }
}
