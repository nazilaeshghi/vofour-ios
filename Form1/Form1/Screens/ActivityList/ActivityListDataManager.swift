//
//  ActivityListDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol ActivityListDataManagable {
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel]
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel]
}

class ActivityListDataManager: ActivityListDataManagable {
    private let dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel] {
        if currentWeek {
            return dataManager.fetchCurrentWeekGoalsTasks()
        }
        else {
            return []
        }
    }
    
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel] {
        return []
    }
}
