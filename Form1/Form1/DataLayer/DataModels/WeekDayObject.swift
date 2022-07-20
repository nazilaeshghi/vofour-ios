//
//  WeekDayObject.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct WeekDayObject {
    let index: Int
    let name: String
    var selected: Bool
    let id: String
}

struct WeekDayBuilder {
    static func build() -> [WeekDayObject] {
        return
            [
                WeekDayObject(index: 0, name: "ش", selected: true, id: "week_day_1"),
                WeekDayObject(index: 1, name: "ی", selected: true, id: "week_day_2"),
                WeekDayObject(index: 2, name: "د", selected: true, id: "week_day_3"),
                WeekDayObject(index: 3, name: "س", selected: true, id: "week_day_4"),
                WeekDayObject(index: 4, name: "چ", selected: true, id: "week_day_5"),
                WeekDayObject(index: 5, name: "پ", selected: true, id: "week_day_6"),
                WeekDayObject(index: 6, name: "ج", selected: true, id: "week_day_7")
            ]
    }
}

enum WeekDay {
    case sat, sun, mon, tue, wed, thu, fri
    
    var index: Int {
        switch self {
        case .sat:
            return 0
        case .sun:
            return 1
        case .mon:
            return 2
        case .tue:
            return 3
        case .wed:
            return 4
        case .thu:
            return 5
        case .fri:
            return 6
        }
    }
    var name: String {
        switch self {
        case .sat:
            return "ش"
        case .sun:
            return "ی"
        case .mon:
            return "د"
        case .tue:
            return "س"
        case .wed:
            return "چ"
        case .thu:
            return "پ"
        case .fri:
            return "ج"
        }
    }
    
    var id: String {
        switch self {
        case .sat:
            return "week_day_1"
        case .sun:
            return "week_day_2"
        case .mon:
            return "week_day_3"
        case .tue:
            return "week_day_4"
        case .wed:
            return "week_day_5"
        case .thu:
            return "week_day_6"
        case .fri:
            return "week_day_7"
        }
    }
}
