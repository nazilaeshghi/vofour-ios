//
//  ActivityListCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class ActivityListCoordinator {
    private var viewModel: ActivityListViewModel!
    
    var destinationView: Form1ListView {
        return Form1ListView(viewModel: self.viewModel)
    }
    
    required init(dataManager: DataManager) {
        let activityListDataManager = ActivityListDataManager(dataManager: dataManager)
        self.viewModel = ActivityListViewModel(dataManager: activityListDataManager)
    }
}
