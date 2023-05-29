//
//  HomeViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    private let dataManager: HomeDataManagable
    @Published var contexs = [HomeContextItemDisplayModel]()
    @Published var todayProgress: Float = 0.0
    @Published var weekProgress: Float = 0.0

    init(dataManager: HomeDataManagable) {
        self.dataManager = dataManager
    }
    
    func fetchData() {
        let models = dataManager.fetchContexts().map {
            transformContexts(model: $0)
        }
        contexs = models.sorted(by: { $0.activityCount > $1.activityCount })
        calculateProgress()
    }
    
    private func transformContexts(model: HomeContextDataModel) -> HomeContextItemDisplayModel {
        let title = LabelDisplayModel(plainText: model.context.name, style: .regularBody)
        let subtitle: LabelDisplayModel
        if model.activityCount > 0 {
            subtitle = LabelDisplayModel(plainText: "\(model.activityCount) \(LocalizedString.Home.activity)".convertToPersian(),
                                         style: .secondaryRegularBody)
        }
        else {
            subtitle = LabelDisplayModel(plainText: LocalizedString.Home.add,
                                         style: .secondaryRegularBody)
        }
        return HomeContextItemDisplayModel(title: title,
                                           imageName: model.context.iconName,
                                           contextID: model.context.id,
                                           contextName: subtitle,
                                           activityCount: model.activityCount)
    }
    
    private func calculateProgress() {
        todayProgress = dataManager.fetchTodayProgress()
        weekProgress = dataManager.fetchWeekProgress()
    }
}
