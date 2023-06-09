//
//  SelectGoalDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol SelectGoalDataManagable {
    func fetchListOfGoals() -> [Goal]
    func createGoal(title: String)
    func selectGoal(with id: String)
    var selectedGoalId: String? { get }
}

protocol CreateeGoalDataManagable {
    func createGoal(title: String) -> String
    func findGoal(title: String) -> Goal?
}


class SelectGoalDataManager: SelectGoalDataManagable {
    private let dataManager: DataManager
    
    var selectedGoalId: String? {
        return dataManager.currentInputEntry.goalID
    }
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchListOfGoals() -> [Goal] {
        return dataManager.fetchGoals()
    }
    
    func createGoal(title: String) {
        let _ = dataManager.createGoal(title: title)
    }
    
    func selectGoal(with id: String) {
        dataManager.currentInputEntry.updateGoalID(with: id)
    }
    
}

class CreateGoalDataManager: CreateeGoalDataManagable {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func createGoal(title: String) -> String {
        return dataManager.createGoal(title: title)
    }
    
    func findGoal(title: String) -> Goal? {
        return dataManager.findGoal(title: title)
    }
}

class CreateGoalDataManagerMock: CreateeGoalDataManagable {
    func createGoal(title: String) -> String {
        return "ورزش"
    }
    
    func findGoal(title: String) -> Goal? {
        return nil
    }
}
