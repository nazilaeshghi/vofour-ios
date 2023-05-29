//
//  HomeCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class HomeCoordinator {    
    private var viewModel: SelectContextViewModel!
    
    var destinationView: ContextListView {
        return ContextListView(viewModel: self.viewModel)
    }
    
    required init(dataManage: DataManager) {
        let innerDataManager = SelectContextDataManager(dataManager: dataManage)
        self.viewModel = SelectContextViewModel(dataManager: innerDataManager)
    }
}


