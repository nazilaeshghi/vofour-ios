//
//  TaskListCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskListCoordinator {
    private var viewModel: WeekViewModel!
    
    var destinationView: WeekView {
        return WeekView(viewModel: self.viewModel)
    }
    
    required init(dataManage: DataManager) {
        let dataManager = WeekDataManager(dataManager: dataManage)
        self.viewModel = WeekViewModel(dataManager: dataManager)
    }
}
