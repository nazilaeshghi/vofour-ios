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
            items = transformGoals(goals: activityListGoals, isAll: true)
        } else {
            guard let goalId = segments[safe: selectedGoalIndex]?.object else { return }
            let activityListGoals = dataManager.fetchGoal(goalId: goalId, currentWeek: currentWeek)
            items = transformGoals(goals: activityListGoals, isAll: false)
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
    
    private func transformGoals(goals: [ActivityGoalDataModel], isAll: Bool) -> [ActiviyListSectionCard] {
        return goals.map { item in
            return ActiviyListSectionCard(id: item.goal.id,
                                          title: LabelDisplayModel(plainText: item.goal.title, style: .mediumTitle),
                                          iconName: nil,
                                          items: transformGoalTasks(hTasks: item.tasks, goal: item.goal, isAll: isAll))
        }
    }
    
    private func transformGoalTasks(hTasks: [HashableTask], goal: Goal, isAll: Bool) -> [ActiviyListItemCard] {
        return hTasks.map { hashableTask in
            let subtitleStr = isAll ? hashableTask.context.name + " | " + goal.title : hashableTask.context.name
            return ActiviyListItemCard(id: hashableTask.task.taskID,
                                       title: LabelDisplayModel(plainText: hashableTask.task.title, style: .regularMediumTitle),
                                       subtitle: LabelDisplayModel(plainText: subtitleStr, style: .secondaryRegularBody),
                                       color: Color(hex: hashableTask.task.color),
                                       progress: hashableTask.progress,
                                       iconName: hashableTask.context.iconName,
                                       isQuit: !hashableTask.task.isActivity)
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
    let isQuit: Bool
}
