//
//  DataProvider.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol DataProvider {
    func saveContexts()
    func addTask()
    func fetchTasks() -> [TaskDataModel]
    
    func fetchContexts() -> [Context]
    func findContext(id: String) -> Context?
    
    func fetchGoals() -> [Goal]
    func createGoal(newEntity: Goal)
    func findGoal(with id: String) -> Goal?
}
