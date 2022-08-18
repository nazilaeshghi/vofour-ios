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

extension Date {
    func getHoursMinutes() -> DateComponents {
        let calendar = DateHelper.getCurrentCalendar()
        let dateComponents = calendar.dateComponents([.hour,.minute], from: self)
        return dateComponents
    }
}

