//
//  TaskRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift
import Foundation

@objcMembers class TaskRealm : Object, TaskDataModel {
    var taskID: String = "-"
    var title: String = ""
    var isItQuit: Bool = false
    var goalId: String?
    var prevention: String?
    var reason: String?
    var completionMotivations: String?
    var color: String = StaticColors.colors.first!
    var weekDays: [String] = []
    var startDate: Date?
    var endDate: Date?
    
    convenience init(task: DataEntryDataModel) {
        self.init()
        self.taskID = UUID().uuidString
        self.isItQuit = task.isActivity ?? true
        self.goalId = task.goalID
        self.prevention = task.prevention
        self.reason = task.reason
        self.completionMotivations = task.for100
        self.color = task.color ?? StaticColors.colors.first!
        if let days = task.days {
            self.weekDays = days.map { $0.id }
        }
        self.startDate = task.startDate
        self.endDate = task.endDate
    }
    
    override class func primaryKey() -> String {
        return "taskID"
    }
}
