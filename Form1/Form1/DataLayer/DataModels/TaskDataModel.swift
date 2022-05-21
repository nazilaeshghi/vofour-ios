//
//  TaskDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation


protocol TaskDataModel {
    var taskID: String { get }
    var isItQuit: Bool { get }
    var title: Bool { get }
    var goal: Goal? { get }
    var prevention: String? { get }
    var reason: String? { get }
    var completionMotivations: String? { get }
    var reminders: [Date]? { get }
    var color: TaskColor { get }
}

protocol Repetition {
    var isItOnce: Bool { get }
    var startDate: Date { get }
    var endDateDate: Date? { get }
    var duration: DateInterval? { get }
    var weekdays: [WeekDay]? { get }
    var dayRepeat: Int? { get }
}

protocol WeekDay {
    var dayId: String { get }
    var name: String { get }
}

protocol Context {
    var contextID: String { get }
    var name: String { get }
    var iconName: String { get }
    var isActive: Bool { get }
}

protocol Goal {
    var goalID: String { get }
    var title: String { get }
}

protocol TaskColor {
    var name: String { get }
    var hex: String { get }
}

struct ContextItemDisplayModel {
    let id = UUID()
    var title: LabelDisplayModel
    var imageName: String
}

struct SelectGoalDisplayModel {
    let id = UUID()
    let title: LabelDisplayModel
    let imageName: String = "flag"
    let selected: Bool
}

