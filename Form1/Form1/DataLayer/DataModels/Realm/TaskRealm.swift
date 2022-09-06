//
//  TaskRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift
import Foundation

@objcMembers class TaskRealm: Object, TaskDataModel {
    var taskID: String = "-"
    var title: String = ""
    var isActivity: Bool = false
    var goalId: String?
    var prevention: String?
    var reason: String?
    var completionMotivations: String?
    var color: String = StaticColors.colors.first!
    var startDate: Date?
    var endDate: Date?
    var isRepeatable: Bool = false
    var weekDays: String = ""
    var contextId: String = "-1"
    var numberOfRepeat: Int = 0
    var reminders: String = ""
    
    convenience init(task: DataEntryDataModel) {
        self.init()
        self.taskID = UUID().uuidString
        self.contextId = task.contextId ?? "-1"
        self.title = task.activityTitle ?? ""
        self.isActivity = task.isActivity
        self.goalId = task.goalID
        self.prevention = task.prevention
        self.reason = task.reason
        self.completionMotivations = task.completionMotivations
        self.color = task.color ?? StaticColors.colors.first!
        self.weekDays = (task.days ?? []).getStringRepresentative()
        self.startDate = task.startDate
        self.endDate = task.endDate
        self.isRepeatable = task.isRepeatable ?? false
        self.numberOfRepeat = task.numberOfRepeat ?? 1
        self.reminders = task.reminders.getStringRepresentative()
    }
    
    override class func primaryKey() -> String {
        return "taskID"
    }
}
