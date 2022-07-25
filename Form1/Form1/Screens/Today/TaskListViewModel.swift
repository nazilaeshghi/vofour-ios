//
//  TodayViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

class TaskListViewModel: ObservableObject {
    private let dataManager: TaskListDataManagable
    
    init(dataManager: TaskListDataManagable) {
        self.dataManager = dataManager
    }
    
    @Published var cards: [CardDisplayModel] = []
    
    func getTasks(date: Date) {
        let tasks = dataManager.fetchTasks(date: date)
        cards = tasks.map { transformDataModels(taskModel: $0) }
    }
    
    private func transformDataModels(taskModel: TaskDataModel) -> CardDisplayModel {
        let title = LabelDisplayModel(plainText: taskModel.title)
        let subtitle = LabelDisplayModel(plainText: "این هفته: ۴ بار", style: .subtitleStyle)
        let count = LabelDisplayModel(plainText: "۳", style: .number)
        let displayModel = CardDisplayModel(title: title,
                                            subtitle: subtitle,
                                            count: count,
                                            background: Color(hex: taskModel.color),
                                            state: .done,
                                            progress: 0.3,
                                            id: taskModel.taskID)
        return displayModel
    }

}
