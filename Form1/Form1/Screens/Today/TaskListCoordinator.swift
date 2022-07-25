//
//  TaskListCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskListCoordinator {
    private var viewModel: TaskListViewModel!
    
    var destinationView: TaskListView {
        return TaskListView(viewModel: viewModel)
    }
    
    required init(dataManage: DataManager) {
        let dataManager = TaskListDataManager(dataManager: dataManage)
        self.viewModel = TaskListViewModel(dataManager: dataManager)
    }
}
