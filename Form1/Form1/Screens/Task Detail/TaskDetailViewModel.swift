//
//  TaskDetailViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    @Published var item: CardDisplayModel?
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable) {
        self.dataManager = dataManager
    }
    
    func fetchDetails() {
        guard let task = dataManager.fetchTaskDetail() else { return }
        item = TaskListViewModel.transformDataModels(dayRecord: task)
    }
    
    func increment() {
        dataManager.increment()
    }
    
    func decrement() {
        dataManager.decrement()
    }
}
