//
//  CreateGoalDataManager.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-12.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

protocol CreateeGoalDataManagable {
    func createGoal(title: String) -> String
    func findGoal(title: String) -> Goal?
}

class CreateGoalDataManager: CreateeGoalDataManagable {
    @Injected(\.dataManagerProvider) internal var dataManager: DataManager
    
    init() {}
    
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
