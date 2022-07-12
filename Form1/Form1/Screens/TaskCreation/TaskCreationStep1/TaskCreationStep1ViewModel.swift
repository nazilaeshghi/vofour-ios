//
//  TaskCreationStep1ViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskCreationStep1ViewModel: ObservableObject {
    private let dataManager: TaskCreationStep1DataManagable
    @Published private(set) var selectedGoalTitle: String?
    
    init(dataManager: TaskCreationStep1DataManagable) {
        self.dataManager = dataManager
        selectedGoalTitle = dataManager.getSelectedGoalTitle()
    }
    
    func header() -> String {
        return LocalizedString.TaskCreationStep1.header(context: dataManager.getContextName())
    }
    
    func update(segemntSelection: Int) {
        dataManager.updateIsActivity(with: segemntSelection == 0)
    }
    
    func updateActivityTitle(title: String) {
        dataManager.updateActivityTitle(with: title)
    }
    
    func updateActivityPrevention(text: String) {
        dataManager.updatePrevention(with: text)
    }
    
    func updateActivityReason(text: String) {
        dataManager.updateReason(with: text)
    }
    
    func updateActivityFor100(text: String) {
        dataManager.updateFor100(with: text)
    }
    
    func getSelectedGoalID() -> String? {
        return dataManager.getSelectedGoalID()
    }
    
    func refreshGoalTitle() {
        selectedGoalTitle = dataManager.getSelectedGoalTitle()
    }
}
