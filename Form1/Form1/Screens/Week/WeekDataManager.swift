//
//  TodayDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskListDataManagable {
    func fetchTasks(date: Date) -> [DailyTaskDataModel]
    func increamentTask(taskID: String, date: Date)
    func fetchDateProgress(date: Date) -> Float
    func fetchWeekProgress(selectedDate: Date) -> Float
}

class WeekDataManager: TaskListDataManagable {
    @Injected(\.dataManagerProvider) internal var dataManager: DataManager

    
    init() {}
    
    func fetchTasks(date: Date) -> [DailyTaskDataModel] {
        return dataManager.fetchDailyTasks(for: date)
    }
    
    func increamentTask(taskID: String, date: Date) {
        dataManager.updateRecord(taskID: taskID, date: date, increment: true)
    }
    
    func fetchDateProgress(date: Date) -> Float {
        return dataManager.computeDayProgress(date: date)
    }
    
    func fetchWeekProgress(selectedDate: Date) -> Float {
        return dataManager.computeWeekProgress(selectedDate: selectedDate)
    }

}
