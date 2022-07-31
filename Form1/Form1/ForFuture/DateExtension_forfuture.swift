//
//  DateExtension_forfuture.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-31.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

extension Date {
    func getPersianRelativeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.calendar = DateHelper.getCurrentCalendar()
        let monthString = dateFormatter.string(from: self)
        return monthString
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
