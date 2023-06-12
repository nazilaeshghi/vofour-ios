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
    
    required init() {
        let activityListDataManager = ActivityListDataManager()
        self.viewModel = GoalsListViewModel(dataManager: activityListDataManager)
    }
}
