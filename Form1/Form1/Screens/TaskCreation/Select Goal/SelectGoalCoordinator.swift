//
//  SelectGoalCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectGoalContext: DestinationContext {
    var destinationIdentifier: DestinationIdentifier { "SelectGoalContext" }
}

class SelectGoalCoordinator {
    private var context: SelectGoalContext
    private var viewModel: SelectGoalViewModel!
    
    var destinationView: SelectGoalView {
        return SelectGoalView(viewModel: self.viewModel)
    }
    
    required init(context: SelectGoalContext, dataManage: DataManager) {
        self.context = context
        let innerDataManager = SelectGoalDataManager(dataManager: dataManage)
        self.viewModel = SelectGoalViewModel(dataManager: innerDataManager)
    }
}
