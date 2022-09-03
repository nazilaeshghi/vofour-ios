//
//  TaskDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI

protocol TaskDataModel {
    var taskID: String { get }
    var isActivity: Bool { get }
    var title: String { get }
    var goalId: String? { get }
    var prevention: String? { get }
    var reason: String? { get }
    var completionMotivations: String? { get }
    var color: String { get }
    var weekDays: String { get }
    var startDate: Date? { get }
    var endDate: Date? { get }
    var isRepeatable: Bool { get }
    var numberOfRepeat: Int { get }
    var contextId: String { get }
    var reminders: String { get }
}

protocol Repetition {
    var isItOnce: Bool { get }
    var startDate: Date { get }
    var endDateDate: Date? { get }
    var duration: DateInterval? { get }
    var weekdays: [WeekDayObj]? { get }
    var dayRepeat: Int? { get }
}

protocol WeekDayObj {
    var dayId: String { get }
    var name: String { get }
}

protocol TaskColor {
    var name: String { get }
    var hex: String { get }
}

protocol Record {
    var recordID: String { get }
    var taskID: String { get }
    var date: Date { get }
    var count: Int { get }
    var total: Int { get }
}

struct DailyTaskDataModel {
    let task: TaskDataModel
    let record: Record?
}

struct HomeContextDataModel {
    let context: TaskContext
    let activityCount: Int
}
