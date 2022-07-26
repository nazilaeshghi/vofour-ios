//
//  Globals.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-26.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct Globals {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.calendar = Calendar(identifier: .persian)
        return formatter
    }()
    
    static func makeDurations() -> [DurationObject] {
        [ DurationObject(tag: 0, id: "du_0", amount: TimeInterval(0.5*60*60)),
          DurationObject(tag: 1, id: "du_1", amount: TimeInterval(1*60*60)),
          DurationObject(tag: 2, id: "du_2", amount: TimeInterval(1.5*60*60)),
          DurationObject(tag: 3, id: "du_3", amount: TimeInterval(2*60*60)),
          DurationObject(tag: 4, id: "du_4", amount: TimeInterval(2.5*60*60)),
          DurationObject(tag: 5, id: "du_5", amount: TimeInterval(3*60*60)),
          DurationObject(tag: 6, id: "du_6", amount: TimeInterval(3.5*60*60)),
          DurationObject(tag: 7, id: "du_7", amount: TimeInterval(4*60*60)),
          DurationObject(tag: 8, id: "du_8", amount: TimeInterval(4.5*60*60)),
          DurationObject(tag: 9, id: "du_9", amount: TimeInterval(5*60*60)),
          DurationObject(tag: 10, id: "du_10", amount: TimeInterval(5.5*60*60)),
          DurationObject(tag: 11, id: "du_11", amount: TimeInterval(6*60*60)),
          DurationObject(tag: 12, id: "du_12", amount: TimeInterval(6.5*60*60)),
          DurationObject(tag: 13, id: "du_13", amount: TimeInterval(7*60*60)),
          DurationObject(tag: 14, id: "du_14", amount: TimeInterval(7.5*60*60)),
          DurationObject(tag: 15, id: "du_15", amount: TimeInterval(8*60*60)),
          DurationObject(tag: 16, id: "du_16", amount: TimeInterval(8.5*60*60)),
          DurationObject(tag: 17, id: "du_17", amount: TimeInterval(9*60*60)),
          DurationObject(tag: 18, id: "du_18", amount: TimeInterval(9.5*60*60)),
          DurationObject(tag: 19, id: "du_19", amount: TimeInterval(10*60*60)),
          DurationObject(tag: 20, id: "du_20", amount: TimeInterval(10.5*60*60)),
          DurationObject(tag: 21, id: "du_021", amount: TimeInterval(11*60*60)),
          DurationObject(tag: 22, id: "du_22", amount: TimeInterval(11.5*60*60)),
          DurationObject(tag: 23, id: "du_23", amount: TimeInterval(12*60*60)),
          DurationObject(tag: 24, id: "du_24", amount: TimeInterval(12.5*60*60)),
          DurationObject(tag: 25, id: "du_25", amount: TimeInterval(13*60*60)),
          DurationObject(tag: 26, id: "du_26", amount: TimeInterval(13.5*60*60)),
          DurationObject(tag: 27, id: "du_27", amount: TimeInterval(14*60*60)),
          DurationObject(tag: 28, id: "du_28", amount: TimeInterval(14.5*60*60)),
          DurationObject(tag: 29, id: "du_29", amount: TimeInterval(15*60*60)),
          DurationObject(tag: 30, id: "du_30", amount: TimeInterval(15.5*60*60)),
          DurationObject(tag: 31, id: "du_31", amount: TimeInterval(16*60*60)),
          DurationObject(tag: 32, id: "du_32", amount: TimeInterval(16.5*60*60)),
          DurationObject(tag: 33, id: "du_33", amount: TimeInterval(17*60*60)),
          DurationObject(tag: 34, id: "du_34", amount: TimeInterval(17.5*60*60)),
          DurationObject(tag: 35, id: "du_35", amount: TimeInterval(18*60*60)),
          DurationObject(tag: 36, id: "du_36", amount: TimeInterval(18.5*60*60)),
          DurationObject(tag: 37, id: "du_37", amount: TimeInterval(19*60*60)),
          DurationObject(tag: 38, id: "du_38", amount: TimeInterval(19.5*60*60)),
          DurationObject(tag: 39, id: "du_39", amount: TimeInterval(20*60*60)),
          DurationObject(tag: 40, id: "du_40", amount: TimeInterval(20.5*60*60)),
          DurationObject(tag: 41, id: "du_41", amount: TimeInterval(21*60*60)),
          DurationObject(tag: 42, id: "du_42", amount: TimeInterval(21.5*60*60)),
          DurationObject(tag: 43, id: "du_43", amount: TimeInterval(22*60*60)),
          DurationObject(tag: 44, id: "du_44", amount: TimeInterval(22.5*60*60)),
          DurationObject(tag: 45, id: "du_45", amount: TimeInterval(23*60*60)),
          DurationObject(tag: 46, id: "du_46", amount: TimeInterval(23.5*60*60)),
          DurationObject(tag: 47, id: "du_47", amount: TimeInterval(24*60*60))
        ]
    }
    
    static func getPersinaCalendar() -> Calendar {
        var pCalendar = Calendar.init(identifier: .persian)
        pCalendar.firstWeekday = 7
        return pCalendar
    }
}
