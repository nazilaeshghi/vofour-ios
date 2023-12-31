//
//  TaskListViewMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-25.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct MockTodayDataManagable: TaskListDataManagable {
    func fetchTasks(date: Date) -> [DailyTaskDataModel] { return [] }
    func increamentTask(taskID: String, date: Date) {}
    func fetchDateProgress(date: Date) -> Float { return 0.3 }
    func fetchWeekProgress(selectedDate: Date) -> Float { return 0.4 }
}

struct TaskDataModelMock: TaskDataModel {
    var taskID: String = "id"
    var isActivity: Bool = true
    var title: String = "ورزش"
    var goalId: String = "-1"
    var prevention: String?
    var reason: String?
    var completionMotivations: String?
    var color: String = "#EA4C89"
    var weekDays: String = "week_day_1"
    var startDate: Date?
    var endDate: Date?
    var isRepeatable: Bool = true
    var numberOfRepeat: Int = 1
    var contextId: String = "-1"
    var reminders: String = "09:10"
    var duration: TimeInterval? = TimeInterval(0.5*60*60)
}
