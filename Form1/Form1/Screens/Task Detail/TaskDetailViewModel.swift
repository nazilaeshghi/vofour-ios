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
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable, currentDate: Date) {
        self.dataManager = dataManager
        self.currentDate = currentDate
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
            self.startDate = DateHelper.fullDateFormatter.string(from: startDate)
        }
        if let endDate = task.task.endDate {
            self.endDate = DateHelper.fullDateFormatter.string(from: endDate)
        }
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
}
