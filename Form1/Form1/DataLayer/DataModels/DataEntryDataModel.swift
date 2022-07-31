//
//  DataEntryDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class DataEntryDataModel {
    private (set) var contextId: String?
    private (set) var isActivity: Bool = true
    private (set) var activityTitle: String?
    private (set) var prevention: String?
    private (set) var reason: String?
    private (set) var for100: String?
    private (set) var goalID: String?
    private (set) var isRepeatable: Bool = false
    private (set) var startDate: Date?
    private (set) var endDate: Date?
    private (set) var duration: TimeInterval?
    private (set) var color: String?
    private (set) var numberOfRepeat: Int?
    private (set) var days: [WeekDayObject]?
    
    func updateContextId(id: String) {
        self.contextId = id
        self.isRepeatable = false
    }
    
    func updateIsActivity(with value: Bool) {
        self.isActivity = value
    }
    
    func updateTitle(with value: String) {
        activityTitle = value
    }
    
    func updatePrevention(with value: String) {
        prevention = value
    }
    
    func updateReason(with value: String) {
        reason = value
    }
    
    func updateFor100(with value: String) {
        for100 = value
    }
    
    func updateGoalID(with value: String) {
        goalID = value
    }
    
    func updateIsRepeatable(with value: Bool) {
        isRepeatable = value
    }
    
    func updateStartDate(with value: Date?) {
        startDate = value
    }
    
    func updateEndDate(with value: Date?) {
        endDate = value
    }
    
    func updateduration(with value: TimeInterval) {
        duration = value
    }
    
    func updateWeekDays(with value: [WeekDayObject]) {
        days = value
    }
    
    func updateNumberOfRepeat(with value: Int) {
        numberOfRepeat = value
    }
    
    func updateColor(with value: String) {
        color = value
    }

}

extension Array where Element == WeekDayObject {
    func getStringRepresentative() -> String {
        return self.filter{ $0.selected }.map{ $0.id }.joined(separator: ", ")
    }
}

struct RecordEntry: Record {
    var recordID: String
    var taskID: String
    var date: Date
    var count: Int
    var total: Int
}
