//
//  TaskCreationStep2Coordinator.swift
//  Form2
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-25.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskCreationStep2Coordinator {
    static var destinationIdentifier: DestinationIdentifier = TodayDestinationContext().destinationIdentifier
    
    private var viewModel: TaskCreationStep2ViewModel!
    
    var destinationView: TaskCreationStep2View {
        return TaskCreationStep2View(viewModel: self.viewModel)
    }
    
    required init(dataManage: DataManager) {
        let innerDataManager = TaskCreationStep2DataManager(dataManager: dataManage)
        self.viewModel = TaskCreationStep2ViewModel(dataManager: innerDataManager)
    }
}
