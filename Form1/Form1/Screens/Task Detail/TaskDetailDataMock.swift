//
//  TaskDetailDataMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-16.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailDataMock: TaskDetailDataManagable {
    func fetchTaskDetail() -> DailyTaskDataModel? {
        return DailyTaskDataModel(task: TaskDataModelMock(), record: RecordEntry(recordID: "", taskID: "", date: Date(), count: 2, total: 5))
    }
    func fetchContext(id: String) -> TaskContext? { SelectContextCellMockGenerator.context }
    
    func fetchGoal(id: String) -> Goal? { SelectGoalCellMockGenerator.goals.first }
    
    func increment() {}
    
    func decrement() {}
    
    func deleteTask() {}
}
