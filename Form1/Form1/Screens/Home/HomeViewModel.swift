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

    init(dataManager: HomeDataManagable) {
        self.dataManager = dataManager
    }
    
    @Published var items =  [CardDisplayModel]()
    
    func fetchTasks(date: Date) {
       // let tasks = dataManager.fetchTask(date: <#T##Date#>)
        
    }
    
    private func transformTasks(task: TaskDataModel) -> CardDisplayModel {
        
        let title = LabelDisplayModel(plainText: task.title)
        let subtitle = LabelDisplayModel(plainText: "این هفته: ۴ بار",
                                         style: .subtitleStyle)
        let count = LabelDisplayModel(plainText: "۳", style: .number)
        
        return CardDisplayModel(title: title,
                                subtitle: subtitle,
                                count: count,
                                background: Color(hex: task.color),
                                state: .done,
                                progress: 0.3,
                                id: task.taskID)
    }
}
