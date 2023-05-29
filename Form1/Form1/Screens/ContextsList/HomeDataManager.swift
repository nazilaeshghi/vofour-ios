//
//  HomeDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol HomeDataManagable {
    func fetchContexts() -> [HomeContextDataModel]
    func fetchTodayProgress() -> Float
    func fetchWeekProgress() -> Float
}

class HomeDataManager: HomeDataManagable {
    
    private let dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchContexts() -> [HomeContextDataModel] {
        return dataManager.fetchAllHomeContexts()
    }
    
    func fetchTodayProgress() -> Float {
        return dataManager.computeDayProgress(date: Date())
    }
    
    func fetchWeekProgress() -> Float {
        //return dataManager.computeWeekProgress()
        return 1.0
    }
}

struct HomeDataManagerMock: HomeDataManagable {
    func fetchTodayProgress() -> Float {
        return 0
    }
    
    func fetchWeekProgress() -> Float {
        return 0
    }
    
    func fetchContexts() -> [HomeContextDataModel] {
        return [HomeContextDataModel(context: SelectContextCellMockGenerator.context,
                                     activityCount: 2),
                HomeContextDataModel(context: SelectContextCellMockGenerator.context,
                                             activityCount: 5),
                HomeContextDataModel(context: SelectContextCellMockGenerator.context,
                                             activityCount: 3),
                HomeContextDataModel(context: SelectContextCellMockGenerator.context,
                                             activityCount: 0)]
    }
}
