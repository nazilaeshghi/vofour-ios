//
//  TodayDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskListDataManagable {
    func fetchTasks(date: Date) -> [TaskDataModel]
}

class TaskListDataManager: TaskListDataManagable {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchTasks(date: Date) -> [TaskDataModel] {
        let dayID = date.getWeekDayID()
        return dataManager.fetchTaks(weekDay: dayID, date: date)
    }
}
