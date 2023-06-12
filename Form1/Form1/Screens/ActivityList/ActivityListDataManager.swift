//
//  ActivityListDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol ActivityListDataManagable {
    func fetchGoals() -> [Goal]
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel]
    func fetchGoal(goalId: String, currentWeek: Bool) -> [ActivityGoalDataModel]
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel]
}

class ActivityListDataManager: ActivityListDataManagable {
    @Injected(\.dataManagerProvider) internal var dataManager: DataManager

    init() {}
    
    func fetchGoals() -> [Goal] {
        return dataManager.fetchGoals()
    }
    
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel] {
        if currentWeek {
            return dataManager.fetchCurrentWeekGoalsTasks()
        }
        else {
            return dataManager.fetchAllGoalsTasks()
        }
    }
    
    func fetchGoal(goalId: String, currentWeek: Bool) -> [ActivityGoalDataModel] {
        if currentWeek, let item = dataManager.fetchCurrentWeekGoalTasks(goalId: goalId) {
            return [item]
        }
        else if !currentWeek, let item = dataManager.fetchGoalTasks(goalId: goalId) {
            return [item]
        } else {
            return []
        }
    }

    
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel] {
        return []
    }
}
