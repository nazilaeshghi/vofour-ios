//
//  TaskRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift
import Foundation

class TaskRealm: Object, TaskDataModel {
    @Persisted (primaryKey: true) var taskID: String = "-"
    @Persisted var title: String = ""
    @Persisted var isActivity: Bool = false
    @Persisted var goalId: String
    @Persisted var prevention: String?
    @Persisted var reason: String?
    @Persisted var completionMotivations: String?
    @Persisted var color: String = StaticColors.colors.first!
    @Persisted var startDate: Date?
    @Persisted var endDate: Date?
    @Persisted var isRepeatable: Bool = false
    @Persisted var weekDays: String = ""
    @Persisted var contextId: String = "-1"
    @Persisted var numberOfRepeat: Int = 0
    @Persisted var reminders: String = ""
    @Persisted var duration: Double?
    
    convenience init(task: DataEntryDataModel) {
        self.init()
        self.taskID = task.taskID ?? UUID().uuidString
        self.contextId = task.contextId ?? "-1"
        self.title = task.activityTitle ?? ""
        self.isActivity = task.isActivity
        self.goalId = task.goalID ?? "-1"
        self.prevention = task.prevention
        self.reason = task.reason
        self.completionMotivations = task.completionMotivations
        self.color = task.color ?? StaticColors.colors.first!
        self.weekDays = (task.days ?? []).getStringRepresentative()
        self.startDate = task.startDate
        self.endDate = task.endDate
        self.duration = task.duration ?? 0.0
        self.isRepeatable = task.isRepeatable ?? false
        self.numberOfRepeat = task.numberOfRepeat ?? (task.isActivity ? 1 : 0)
        self.reminders = task.reminders.getStringRepresentative()
    }
}
