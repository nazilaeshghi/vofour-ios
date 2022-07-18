//
//  TaskCreationStep2DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskCreationStep2DataManagable {
    func getContextName() -> String
    func updateTaskType(isRepeatable: Bool)
    func updateStartDate(date: Date?)
    func updatEndDate(date: Date?)
    func updatDuration(interval: TimeInterval)
    func updateWeekDays(days: [WeekDayObject])
    func updateNumberOfRepeat(int: Int)
    func updateColor(hex: String)
}

class TaskCreationStep2DataManager: TaskCreationStep2DataManagable {
    private let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func getContextName() -> String{
        guard let contextId = dataManager.currentInputEntry.contextId else { return "" }
        return dataManager.context(id: contextId)?.name ?? ""
    }
    
    func updateTaskType(isRepeatable: Bool) {
        dataManager.currentInputEntry.updateIsRepeatable(with: isRepeatable)
    }
    
    func updateStartDate(date: Date?) {
        dataManager.currentInputEntry.updateStartDate(with: date)
    }
    
    func updatEndDate(date: Date?) {
        dataManager.currentInputEntry.updateEndDate(with: date)
    }
    
    func updatDuration(interval: TimeInterval) {
        dataManager.currentInputEntry.updateduration(with: interval)
    }
    
    func updateWeekDays(days: [WeekDayObject]) {
        dataManager.currentInputEntry.updateWeekDays(with: days)
    }
    
    func updateNumberOfRepeat(int: Int) {
        dataManager.currentInputEntry.updateNumberOfRepeat(with: int)
    }
    
    func updateColor(hex: String) {
        dataManager.currentInputEntry.updateColor(with: hex)
    }
}
