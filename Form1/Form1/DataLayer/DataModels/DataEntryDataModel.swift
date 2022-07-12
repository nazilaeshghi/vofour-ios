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
    private (set) var isActivity: Bool?
    private (set) var activityTitle: String?
    private (set) var prevention: String?
    private (set) var reason: String?
    private (set) var for100: String?
    private (set) var goalID: String?
    
    func updateContextId(id: String) {
        self.contextId = id
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
}
