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
    var goalId: String { get }
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
    var duration: Double? { get }
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


struct ActivityGoalDataModel {
    let goal: Goal
    let tasks: [HashableTask]
}

struct HashableTask: Hashable {
    let task: TaskDataModel
    let progress: Float
    let context: TaskContext
    
    static func == (lhs: HashableTask, rhs: HashableTask) -> Bool {
        return lhs.task.taskID == rhs.task.taskID
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(task.taskID)
    }
}

struct ActivityContextDataModel {
    let context: TaskContext
    let tasks: [TaskDataModel]
}


enum ConformingTaskDataModelProtocol : Hashable, CustomStringConvertible {
    var description: String {
        switch self {
        case .FooValue(let v): return v.description
        }
    }
    case FooValue(TaskRealm)

    var hashValue: Int {
        switch self {
        case .FooValue(let v): return v.description.hashValue
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .FooValue(let task):
            hasher.combine(task.taskID)
        }
    }
    
    static func ==(lhs: ConformingTaskDataModelProtocol, rhs: ConformingTaskDataModelProtocol) -> Bool {
        switch (lhs, rhs) {
        case (.FooValue(let l), .FooValue(let r)): return l.description == r.description
        }
    }
}


