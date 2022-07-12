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
    func findGoal(with id: String) -> Goal?
    func selectGoal(with id: String)
    var selectedGoalId: String? { get }
}


class SelectGoalDataManager: SelectGoalDataManagable {
    private let dataManager: DataManager
    private (set) var selectedGoalId: String? = nil
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        self.selectedGoalId = dataManager.currentInputEntry.goalID
    }
    
    func fetchListOfGoals() -> [Goal] {
        return dataManager.fetchGoals()
    }
    
    func createGoal(title: String) {
        selectedGoalId = dataManager.createGoal(title: title)
    }
    
    func findGoal(with id: String) -> Goal? {
        return nil
    }
    
    func selectGoal(with id: String) {
        dataManager.currentInputEntry.updateGoalID(with: id)
    }
    
}
