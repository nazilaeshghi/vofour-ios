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
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable, currentDate: Date) {
        self.dataManager = dataManager
        self.currentDate = currentDate
    }
    
    func fetchDetails() {
        guard let task = dataManager.fetchTaskDetail() else { return }
        item = TaskListViewModel.transformDataModels(dayRecord: task)
        item.subtitle = LabelDisplayModel(plainText: "از " + "\(task.record?.total ?? 0)", style: .subtitleStyle)
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
