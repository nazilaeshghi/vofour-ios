//
//  ActivityListCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class ActivityListCoordinator {
    private var viewModel: GoalsListViewModel!
    
    var destinationView: GoalsListView {
        return GoalsListView(viewModel: self.viewModel, currentWeekIsOn: false)
    }
    
    required init(dataManager: DataManager) {
        let activityListDataManager = ActivityListDataManager(dataManager: dataManager)
        self.viewModel = GoalsListViewModel(dataManager: activityListDataManager)
    }
}
