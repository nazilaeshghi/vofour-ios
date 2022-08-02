//
//  TaskCreationStep1DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskCreationStep1DataManagable {
    func getContextName() -> String
    func updateIsActivity(with value: Bool)
    func updateActivityTitle(with value: String)
    func updatePrevention(with value: String)
    func updateReason(with value: String)
    func updateFor100(with value: String)
    func getSelectedGoalID() -> String?
    func getSelectedGoalTitle() -> String?
    var contextID: String? { get }
}

class TaskCreationStep1DataManager: TaskCreationStep1DataManagable {

    private let dataManager: DataManager

    private (set) var contextID: String?
    init(dataManager: DataManager, contextID: String?) {
        self.dataManager = dataManager
        self.contextID = contextID
        // by default all
        updateIsActivity(with: true)
    }
    
    func getContextName() -> String {
        if let contextID = contextID {
            dataManager.currentInputEntry.updateContextId(id: contextID)
        }
        guard let contextId = dataManager.currentInputEntry.contextId else { return "" }
        return dataManager.context(id: contextId)?.name ?? ""
    }
    
    func updateIsActivity(with value: Bool) {
        dataManager.currentInputEntry.updateIsActivity(with: value)
    }
    
    func updateActivityTitle(with value: String) {
        dataManager.currentInputEntry.updateTitle(with: value)
    }
    
    func updatePrevention(with value: String) {
        dataManager.currentInputEntry.updatePrevention(with: value)
    }
    
    func updateReason(with value: String) {
        dataManager.currentInputEntry.updateReason(with: value)
    }
    
    func updateFor100(with value: String) {
        dataManager.currentInputEntry.updateFor100(with: value)
    }
    
    func getSelectedGoalID() -> String? {
        return dataManager.currentInputEntry.goalID
    }
    
    func getSelectedGoalTitle() -> String? {
        return dataManager.findSelectedGoal()?.title
    }

}
