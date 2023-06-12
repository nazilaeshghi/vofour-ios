//
//  HomeCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class ContextsListCoordinator {    
    private var viewModel: SelectContextViewModel!
    
    var destinationView: ContextListView {
        return ContextListView(viewModel: self.viewModel)
    }
    
    required init() {
        let innerDataManager = SelectContextDataManager()
        self.viewModel = SelectContextViewModel(dataManager: innerDataManager)
    }
}


