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
    var title: String { get }
    var goalId: String? { get }
    var prevention: String? { get }
    var reason: String? { get }
    var completionMotivations: String? { get }
    var color: String { get }
   // var weekDays: [String] { get }
    var startDate: Date? { get }
    var endDate: Date? { get }
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
