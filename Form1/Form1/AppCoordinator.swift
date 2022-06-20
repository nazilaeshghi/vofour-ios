//
//  AppCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI

class AppCoordinator {
    
    let dataManager = DataManager(dataProvider: ReqalmDataProvider())
    
    init() {
        dataManager.saveContexts()
    }
    
    var rootView: some View {
        let contextDataManger = SelectContextDataManager(dataManager: dataManager)
        let viewModel = SelectContextViewModel(dataManager: contextDataManger)
        return SelectContext(viewModel: viewModel)
    }
    
    func makeDetailView(context: DestinationContext) -> TaskDetailView? {
        let coordinator = TaskDetailCoordinator(context: context)
        return coordinator?.destinationView
    }
    
    func makeDetailView(with taskID: String) -> TaskDetailView? {
        let destinationContext = TaskDetailContext(taskId: taskID)
        let coordinator = TaskDetailCoordinator(context: destinationContext)
        return coordinator?.destinationView
    }
    
    
    
    
    
    
}
