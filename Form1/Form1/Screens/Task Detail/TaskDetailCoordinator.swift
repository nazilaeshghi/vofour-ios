//
//  TaskDetailCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailCoordinator {    
    private var context: TaskDetailContext?
    private var viewModel: TaskDetailViewModel!
    
    var destinationView: TaskDetailView {
        return TaskDetailView(viewModel: self.viewModel)
    }
    
    required init(context: TaskDetailContext, dataManage: DataManager) {
        self.context = context
        let dataManager = TaskDetailDataManager(taskID: context.taskId,
                                                currentDate: context.selectedDate,
                                                dataManager: dataManage)
        self.viewModel = TaskDetailViewModel(dataManager: dataManager, currentDate: context.selectedDate)
    }
}
