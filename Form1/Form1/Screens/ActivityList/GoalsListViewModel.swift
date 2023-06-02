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
    @Published var selectedGoalIndex: Int = 0
    @Published var currentWeek: Bool = false
    @Published var items: [ActiviyListSectionCard] = []
    @Published var segments: [Segment] = [Segment]()
    
    init(dataManager: ActivityListDataManagable) {
        self.dataManager = dataManager
    }
    
    func reloadData() {
        buildSegment()
        fetchGoalItems()
    }
    
    func fetchGoalItems() {
        if selectedGoalIndex == 0 {
            let activityListGoals = dataManager.fetchGoals(currentWeek: currentWeek)
            items = transformGoals(goals: activityListGoals)
        } else {
            guard let goalId = segments[safe: selectedGoalIndex]?.object else { return }
            let activityListGoals = dataManager.fetchGoal(goalId: goalId, currentWeek: currentWeek)
            items = transformGoals(goals: activityListGoals)
        }
    }
    
    func buildSegment() {
        let goals = dataManager.fetchGoals()
        segments = [Segment(title: LocalizedString.GoalList.allGoals, index: 0)]
        let tempSegments = goals.enumerated().map { Segment(title: $0.element.title,
                                                    index: $0.offset + 1,
                                                    object: $0.element.id) }
        segments.append(contentsOf: tempSegments)
    }
    
    private func transformGoals(goals: [ActivityGoalDataModel]) -> [ActiviyListSectionCard] {
        return goals.map { item in
            return ActiviyListSectionCard(id: item.goal.id,
                                          title: LabelDisplayModel(plainText: item.goal.title, style: .mediumTitle),
                                          iconName: nil,
                                          items: transformGoalTasks(hTasks: item.tasks, goal: item.goal))
        }
    }
    
    private func transformGoalTasks(hTasks: [HashableTask], goal: Goal) -> [ActiviyListItemCard] {
        return hTasks.map { hTask in
            return ActiviyListItemCard(id: hTask.task.taskID,
                                       title: LabelDisplayModel(plainText: hTask.task.title, style: .regularMediumTitle),
                                       subtitle: LabelDisplayModel(plainText: hTask.context.name + " | " + goal.title, style: .secondaryRegularBody),
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
