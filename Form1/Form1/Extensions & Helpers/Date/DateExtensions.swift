//
//  DateExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension Date {
    var isToday: Bool {
        return getSimpleDate() == Date().getSimpleDate()
    }
        
    func getSimpleDate() -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return date
        }
        return date
    }
    
    func getWeekDayID()-> String {
        let index = Calendar.current.component(.weekday, from: self)
        
        switch index {
        case 7:
            return "week_day_1"
        case 1:
            return "week_day_2"
        case 2:
            return "week_day_3"
        case 3:
            return "week_day_4"
        case 4:
            return "week_day_5"
        case 5:
            return "week_day_6"
        case 6:
            return "week_day_7"
        default:
            return "week_day_1"
        }
    }
}
