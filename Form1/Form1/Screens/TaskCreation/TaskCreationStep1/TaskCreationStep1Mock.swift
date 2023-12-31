//
//  TaskCreationStep1Mock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct TaskCreationStep1MockGenerator {}

struct TaskCreationStep1DataManagableMock: TaskCreationStep1DataManagable {
    var dataManager: DataManager = DataManager(dataProvider: MockDataProvider())
    
    func getIsActivity() -> Bool {
        return true
    }
    
    func getActivityTitle() -> String {
        return ""
    }
    
    func getPrevention() -> String {
        return ""
    }
    
    func getReason() -> String {
        return ""
    }
    
    func getFor100() -> String {
        return ""
    }
    
    var contextID: String?
    
    func getContextName(editMode: Bool) -> String {
        return "سلامتی"
    }
    
    func updateIsActivity(with value: Bool) {}
    func updateActivityTitle(with value: String) {}
    func updatePrevention(with value: String) {}
    func updateReason(with value: String) {}
    func updateFor100(with value: String) {}
    func getSelectedGoalID() -> String? { return nil }
    func getSelectedGoalTitle() -> String? { return nil }
    let selectedContextID: String = ""
}
