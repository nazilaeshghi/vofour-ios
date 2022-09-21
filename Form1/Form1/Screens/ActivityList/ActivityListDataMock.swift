//
//  ActivityListDataMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class ActivityListDataMock: ActivityListDataManagable {
    
    func fetchGoals(currentWeek: Bool) -> [ActivityGoalDataModel] {
        return [ActivityGoalDataModel(goal: GoalEntity(id: "-200", title: "هدف من"),
                                      tasks: [
                                        HashableTask(task: TaskDataModelMock(),
                                                     progress: 0.5,
                                                     context: SelectContextCellMockGenerator.context),
                                        HashableTask(task: TaskDataModelMock(),
                                                     progress: 0.7,
                                                     context: SelectContextCellMockGenerator.context)
                                      ])]
    }
    
    func fetchContexts(currentWeek: Bool) -> [ActivityContextDataModel] {
        return []
    }
}
