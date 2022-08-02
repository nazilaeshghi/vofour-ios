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
    
    func makeTabbar() -> some View {
        return AppTabView()
    }
    
    // Task Creation
    func makeSelectContextView() -> SelectContextView {
        let contextDataManger = SelectContextDataManager(dataManager: dataManager)
        let viewModel = SelectContextViewModel(dataManager: contextDataManger)
        return SelectContextView(viewModel: viewModel)
    }
    
    func makeTaskCreationStep1View(contextID: String? = nil) -> TaskCreationStep1View {
        let context = TaskCreationStep1Context(contextID: contextID)
        let coordinator = TaskCreationStep1Coordinator(context: context, dataManage: dataManager)
        return coordinator.destinationView
    }
    
    func makeSelectGoalSheetView() -> SelectGoalView {
        let context = SelectGoalContext()
        let coordinator = SelectGoalCoordinator(context: context, dataManage: dataManager)
        return coordinator.destinationView
    }
    
    func makeTaskCreationStep2View() -> TaskCreationStep2View {
        let coordinator = TaskCreationStep2Coordinator(dataManage: dataManager)
        return coordinator.destinationView
    }
    
    // Task
    func makeTasksListView() -> TaskListView {
        let coordinator = TaskListCoordinator(dataManage: dataManager)
        return coordinator.destinationView
    }
    
    func makeTaskDetailsView(taskId: String, selectedDate: Date) -> TaskDetailView {
        let coordinator = TaskDetailCoordinator(context: TaskDetailContext(taskId: taskId, selectedDate: selectedDate), dataManage: dataManager)
        return coordinator.destinationView
    }

    // Home
    func makeHomeView() -> HomeView {
        let coordinator = HomeCoordinator(dataManage: dataManager)
        return coordinator.destinationView
    }
    
    
}
