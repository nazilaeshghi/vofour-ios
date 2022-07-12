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
    
    private init() {
        dataManager.saveContexts()
    }
    
    static let shared = AppCoordinator()
    
    var rootView: some View {
        return makeSelectContextView()
    }
    
    func makeSelectContextView() -> SelectContext {
        let contextDataManger = SelectContextDataManager(dataManager: dataManager)
        let viewModel = SelectContextViewModel(dataManager: contextDataManger)
        return SelectContext(viewModel: viewModel)
    }
    
    func makeTaskCreationStep1View() -> TaskCreationStep1View {
        let context = TaskCreationStep1Context()
        let coordinator = TaskCreationStep1Coordinator(context: context, dataManage: dataManager)
        return coordinator.destinationView
    }
    
    func makeSelectGoalSheetView() -> SelectGoalView {
        let context = SelectGoalContext()
        let coordinator = SelectGoalCoordinator(context: context, dataManage: dataManager)
        return coordinator.destinationView
    }
    
//    func makeDetailView(context: DestinationContext) -> TaskDetailView? {
//        let coordinator = TaskDetailCoordinator(context: context)
//        return coordinator?.destinationView
//    }
//
//    func makeDetailView(with taskID: String) -> TaskDetailView? {
//        let destinationContext = TaskDetailContext(taskId: taskID)
//        let coordinator = TaskDetailCoordinator(context: destinationContext)
//        return coordinator?.destinationView
//    }

}
