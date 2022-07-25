//
//  TaskCreationStep1Coordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct TaskCreationStep1Context: DestinationContext {
    var destinationIdentifier: DestinationIdentifier { "TaskCreationStep1Context" }
}

class TaskCreationStep1Coordinator {    
    private var context: TaskCreationStep1Context
    private var viewModel: TaskCreationStep1ViewModel!
    
    var destinationView: TaskCreationStep1View {
        return TaskCreationStep1View(viewModel: self.viewModel)
    }
    
    required init(context: TaskCreationStep1Context, dataManage: DataManager) {
        self.context = context
        let innerDataManager = TaskCreationStep1DataManager(dataManager: dataManage)
        self.viewModel = TaskCreationStep1ViewModel(dataManager: innerDataManager)
    }
}
