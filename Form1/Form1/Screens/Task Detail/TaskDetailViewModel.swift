//
//  TaskDetailViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    @Published var item: CardDisplayModel!
    let currentDate: Date
    @Published var didFetchDate: Bool = false
    @Published var activityType: String = ""
    @Published var contextName: String = ""
    @Published var goalName: String = ""
    @Published var startDate: String?
    @Published var endDate: String?
    @Published var weekDays: String?
    @Published var numberOfRepeat: String?
    @Published var prevent: String?
    @Published var reason: String?
    @Published var for100: String?
    @Published var duration: String?
    var isDayMode: Bool
    var repeatTitleStr: String = ""
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable, currentDate: Date, isDayMode: Bool = false) {
        self.dataManager = dataManager
        self.currentDate = currentDate
        self.isDayMode = isDayMode
    }
    
    func fetchDetails() {
        guard let task = dataManager.fetchTaskDetail() else { return }
        item = WeekViewModel.transformDataModels(dayRecord: task)
        
        let subtitleStr = "از " + "\(task.record?.total ?? 0)"
        item.subtitle = LabelDisplayModel(plainText: subtitleStr.convertToPersian(), style: .lightTitle)
        
        item.count.labelStyle = .regularGiantTitleStyle
        item.count.plainText =  item.count.plainText.convertToPersian()
        
        activityType = task.task.isActivity ? LocalizedString.TaskDetail.create : LocalizedString.TaskDetail.quit
        contextName = dataManager.fetchContext(id: task.task.contextId)?.name ?? ""
        goalName = dataManager.fetchGoal(id: task.task.goalId)?.title ?? LocalizedString.TaskDetail.independent
        if let startDate = task.task.startDate {
            self.startDate = DateHelper.fullDateFormatter().string(from: startDate)
        }
        if let endDate = task.task.endDate {
            self.endDate = DateHelper.fullDateFormatter().string(from: endDate)
        }
        
        if task.task.isRepeatable && task.task.isActivity  {
            self.weekDays = getWeekDays(with: task.task.weekDays)
        }
        
        if (task.task.numberOfRepeat != 0) {
            self.numberOfRepeat = String(task.task.numberOfRepeat).convertToPersian()
        }
        
        repeatTitleStr = task.task.isActivity ? LocalizedString.TaskDetail.repeatTitle : LocalizedString.TaskDetail.quitRepeatTitle
        prevent = task.task.prevention
        reason = task.task.reason
        for100 = task.task.completionMotivations
        duration = task.task.duration?.timeStr
        
        didFetchDate = true
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
    
    func hideStartDate() -> Bool {
        return self.startDate == nil
    }
    
    func hideEndDate() -> Bool {
        return self.endDate == nil
    }
    
    func hideWeekDays() -> Bool {
        return weekDays == nil
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
            .map { $0.getFullTitle }
            .joined(separator: "، ")
    }
    
    func hideNumberOfRepeat() -> Bool {
        return numberOfRepeat == nil
    }
    
    func hideReason() -> Bool {
        return reason == nil || reason?.count == 0
    }
    
    func hidePrevent() -> Bool {
        return prevent == nil || prevent?.count == 0
    }
    
    func hideFor100() -> Bool {
        return for100 == nil || for100?.count == 0
    }
    
    func hideDuration() -> Bool {
        return duration == nil || duration?.count == 0
    }
}
