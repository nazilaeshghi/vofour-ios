//
//  HomeDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol HomeDataManagable {
    func fetchTasks() -> [TaskDataModel]
    func fetchTask(date: Date) -> [TaskDataModel]
}

class HomeDataManager: HomeDataManagable {
    func fetchTask(date: Date) -> [TaskDataModel] {
        let weekday = Calendar(identifier: .persian).component(.weekday, from: date)
        return []
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return []
    }
}
