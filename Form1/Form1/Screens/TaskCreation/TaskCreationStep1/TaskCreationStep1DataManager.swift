//
//  TaskCreationStep1DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskCreationStep1DataManagable: BaseDataManagable {
    func getContextName(editMode: Bool) -> String
    
    func getIsActivity() ->  Bool
    func updateIsActivity(with value: Bool)
    
    func getActivityTitle() -> String
    func updateActivityTitle(with value: String)
    
    func getPrevention() -> String
    func updatePrevention(with value: String)
    
    func getReason() -> String
    func updateReason(with value: String)
    
    func getFor100() -> String
    func updateFor100(with value: String)
    
    func getSelectedGoalID() -> String?
    func getSelectedGoalTitle() -> String?
    var contextID: String? { get }
}

class TaskCreationStep1DataManager: TaskCreationStep1DataManagable {
    internal let dataManager: DataManager

    private (set) var contextID: String?
    
    init(dataManager: DataManager, contextID: String?) {
        self.dataManager = dataManager
        self.contextID = contextID
        // by default all
        updateIsActivity(with: true)
        if let contextID = contextID {
            dataManager.currentInputEntry.updateContextId(id: contextID)
        }
    }
    
    func getContextName(editMode: Bool) -> String {
        var currentContextID: String
        if let contextID = contextID, editMode == false {
            currentContextID = contextID
            return dataManager.context(id: contextID)?.name ?? ""
        }
        else {
            currentContextID = dataManager.currentInputEntry.contextId ?? ""
        }
        return dataManager.context(id: currentContextID)?.name ?? ""
    }
    
    func getIsActivity() -> Bool {
        return dataManager.currentInputEntry.isActivity
    }
    func updateIsActivity(with value: Bool) {
        dataManager.currentInputEntry.updateIsActivity(with: value)
    }
    
    func getActivityTitle() -> String {
        return dataManager.currentInputEntry.activityTitle ?? ""
    }
    func updateActivityTitle(with value: String) {
        dataManager.currentInputEntry.updateTitle(with: value)
    }
    
    func getPrevention() -> String {
        return dataManager.currentInputEntry.prevention ?? ""
    }
    func updatePrevention(with value: String) {
        dataManager.currentInputEntry.updatePrevention(with: value)
    }
    
    func getReason() -> String {
        return dataManager.currentInputEntry.reason ?? ""
    }
    func updateReason(with value: String) {
        dataManager.currentInputEntry.updateReason(with: value)
    }
    
    func getFor100() -> String {
        return dataManager.currentInputEntry.completionMotivations ?? ""
    }
    func updateFor100(with value: String) {
        dataManager.currentInputEntry.updateCompletionMotivations(with: value)
    }
    
    func getSelectedGoalID() -> String? {
        return dataManager.currentInputEntry.goalID
    }
    
    func getSelectedGoalTitle() -> String? {
        return dataManager.findSelectedGoal()?.title
    }

}
