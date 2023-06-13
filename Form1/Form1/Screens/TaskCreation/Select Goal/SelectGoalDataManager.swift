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
    func selectGoal(with id: String)
    var selectedGoalId: String? { get }
}

class SelectGoalDataManager: SelectGoalDataManagable {
    @Injected(\.dataManagerProvider) internal var dataManager: DataManager
    
    var selectedGoalId: String? {
        return dataManager.currentInputEntry.goalID
    }
    
    init() {}
    
    func fetchListOfGoals() -> [Goal] {
        return dataManager.fetchGoals()
    }
    
    func selectGoal(with id: String) {
        dataManager.currentInputEntry.updateGoalID(with: id)
    }
    
}


