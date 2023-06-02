//
//  ActivityListDataMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class ActivityListDataMock: ActivityListDataManagable {
    func fetchGoals() -> [Goal] {
        return []
    }
    
    func fetchGoal(goalId: String, currentWeek: Bool) -> [ActivityGoalDataModel] {
        return []
    }
    
    func fetchGoal(currentWeek: Bool) -> [ActivityGoalDataModel] {
        return []
    }
    
    
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel] {
        return []
    }
    
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel] {
        return []
    }
}
