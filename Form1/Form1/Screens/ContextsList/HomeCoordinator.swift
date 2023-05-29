//
//  HomeCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class HomeCoordinator {    
    private var viewModel: HomeViewModel!
    
    var destinationView: HomeView {
        return HomeView(viewModel: self.viewModel)
    }
    
    required init(dataManage: DataManager) {
        let innerDataManager = HomeDataManager(dataManager: dataManage)
        self.viewModel = HomeViewModel(dataManager: innerDataManager)
    }
}


