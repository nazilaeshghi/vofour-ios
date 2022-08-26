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
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable, currentDate: Date) {
        self.dataManager = dataManager
        self.currentDate = currentDate
    }
    
    func fetchDetails() {
        guard let task = dataManager.fetchTaskDetail() else { return }
        item = TaskListViewModel.transformDataModels(dayRecord: task)
        item.subtitle = LabelDisplayModel(plainText: "از " + "\(task.record?.total ?? 0)", style: .subtitleStyle)
        activityType = task.task.isActivity ? LocalizedString.TaskDetail.create : LocalizedString.TaskDetail.quit
        contextName = dataManager.fetchContext(id: task.task.contextId)?.name ?? ""
        goalName = dataManager.fetchGoal(id: task.task.goalId ?? "")?.title ?? LocalizedString.TaskDetail.independent
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
}
