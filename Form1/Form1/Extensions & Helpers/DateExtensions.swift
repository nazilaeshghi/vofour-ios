//
//  DateExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension DateFormatter {
    func optionalDate(from date: String?) -> Date? {
        guard let newDate = date else { return nil }
        return self.date(from: newDate)
    }
}

extension Date {
    func getSimpleDate() -> Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
            return nil
        }
        return date
    }
    
    func getWeekDayID()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: self)
        switch weekDay {
        case "Saturday":
            return "week_day_1"
        case "Sunday":
            return "week_day_2"
        case "Monday":
            return "week_day_3"
        case "Tuesday":
            return "week_day_4"
        case "Wednesday":
            return "week_day_5"
        case "Thursday":
            return "week_day_6"
        case "Friday":
            return "week_day_7"
        default:
            return "week_day_1"
        }
    }
}

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Optional where Wrapped == Date {
    func getSimpleDate() -> Date? {
        guard let date = self,
              let newDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: date)) else {
                  return nil
              }
        return newDate
    }
}
