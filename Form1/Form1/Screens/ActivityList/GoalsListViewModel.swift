//
//  ActivityListViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

class GoalsListViewModel: ObservableObject {
    private let dataManager: ActivityListDataManagable
    @Published var selectedType: Int = 0
    @Published var selectedDuration: Durationtype = .all
    @Published var items: [ActiviyListSectionCard] = []
    
    init(dataManager: ActivityListDataManagable) {
        self.dataManager = dataManager
    }
    
    func reloadData() {
        if selectedType == 0 {
            fetchGoalItems()
        }
        else {
            fetchContextItems()
        }
    }
    
    func fetchGoalItems() {
        let activityListGoals = dataManager.fetchGoals(currentWeek: selectedDuration == .week ? true : false)
        items = transformGoals(goals: activityListGoals)
    }
    
    func fetchContextItems() {
        
    }
    
    var segmentItems: [String] {
        return [
            LocalizedString.ActicityList.golas,
            LocalizedString.ActicityList.contexts
        ]
    }
    
    private func transformGoals(goals: [ActivityGoalDataModel]) -> [ActiviyListSectionCard] {
        return goals.map { item in
            return ActiviyListSectionCard(id: item.goal.id,
                                          title: LabelDisplayModel(plainText: item.goal.title, style: .mediumTitle),
                                          iconName: nil,
                                          items: transformGoalTasks(hTasks: item.tasks))
        }
    }
    
    private func transformGoalTasks(hTasks: [HashableTask]) -> [ActiviyListItemCard] {
        return hTasks.map { hTask in
            return ActiviyListItemCard(id: hTask.task.taskID,
                                       title: LabelDisplayModel(plainText: hTask.task.title, style: .regularMediumTitle),
                                       subtitle: LabelDisplayModel(plainText: hTask.context.name, style: .regularSubtitle),
                                       color: Color(hex: hTask.task.color),
                                       progress: hTask.progress,
                                       iconName: hTask.context.iconName)
        }
    }
}


struct ActiviyListSectionCard: Identifiable {
    var id: String
    var title: LabelDisplayModel
    var iconName: String?
    var items: [ActiviyListItemCard]
}

struct ActiviyListItemCard: Identifiable {
    var id: String
    var title: LabelDisplayModel
    var subtitle: LabelDisplayModel
    var color: Color
    var progress: Float?
    var iconName: String?
}
