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
    @Injected(\.dataManagerProvider) var dataManager: DataManager

    private init() {
        dataManager.saveContexts()
        dataManager.saveDefaultGoal()
    }
    
    static let shared = AppCoordinator()
    
    func makeTabbar() -> some View {
        return AppTabView()
    }
    
    func makeSelectContextSheetView() -> SelectContextSheetView {
        let contextDataManger = SelectContextDataManager()
        let viewModel = SelectContextViewModel(dataManager: contextDataManger)
        return SelectContextSheetView(viewModel: viewModel)
    }
    
    func makeSelectContextView() -> SelectContextView {
        let contextDataManger = SelectContextDataManager()
        let viewModel = SelectContextViewModel(dataManager: contextDataManger)
        return SelectContextView(viewModel: viewModel)
    }
    
    func makeEditTaskCreationStep1View(taskId: String) -> TaskCreationStep1View {
        dataManager.startEditTask(taskId: taskId)
        let task = dataManager.fetchTask(taskID: taskId)
        let innerDataManager = TaskCreationStep1DataManager(contextID: task?.contextId)
        let viewModel = TaskCreationStep1ViewModel(dataManager: innerDataManager, editMode: true)
        return TaskCreationStep1View(viewModel: viewModel)
    }
    
    func makeTaskCreationStep1View(contextId: String? = nil) -> TaskCreationStep1View {
        let contextID: String?
        if let contextId = contextId {
            contextID = contextId
            dataManager.currentInputEntry.updateContextId(id: contextId)
        } else {
            contextID = dataManager.currentInputEntry.contextId
        }
        let innerDataManager = TaskCreationStep1DataManager(contextID: contextID)
        let viewModel = TaskCreationStep1ViewModel(dataManager: innerDataManager, editMode: false)
        return TaskCreationStep1View(viewModel: viewModel)
    }
    
    func makeSelectGoalSheetView() -> SelectGoalView {
        let innerDataManager = SelectGoalDataManager()
        let viewModel = SelectGoalViewModel(dataManager: innerDataManager)
        return SelectGoalView(viewModel: viewModel)
    }
    
    func makeCreateGoalView(isPresented: Binding<Bool>) -> NewGoalView {
        let dataManager = CreateGoalDataManager()
        let viewModel = NewGoalViewModel(dataManger: dataManager)
        return NewGoalView(isPresented: isPresented, viewModel: viewModel)
    }
    
    func makeTaskCreationStep2View(editMode: Bool) -> TaskCreationStep2View {
        let innerDataManager = TaskCreationStep2DataManager()
        let viewModel = TaskCreationStep2ViewModel(dataManager: innerDataManager, editMode: editMode)
        return TaskCreationStep2View(viewModel: viewModel)
        
    }
    
    func makeWeekView() -> WeekView {
        let dataManager = WeekDataManager()
        let viewModel = WeekViewModel(dataManager: dataManager)
        return WeekView(viewModel: viewModel)
    }
    
    func makeTaskDetailsView(taskId: String, selectedDate: Date, isDayMode: Bool = false) -> TaskDetailView {
        let dataManager = TaskDetailDataManager(taskID: taskId,
                                                currentDate: selectedDate)
        let viewModel = TaskDetailViewModel(dataManager: dataManager, currentDate: selectedDate, isDayMode: isDayMode)
        return TaskDetailView(viewModel: viewModel)
    }

    func makeContextListView() -> ContextListView {
        let coordinator = ContextsListCoordinator()
        return coordinator.destinationView
    }
    
    func makeGoalsListView() -> GoalsListView {
        let coordinator = ActivityListCoordinator()
        return coordinator.destinationView
    }
}
