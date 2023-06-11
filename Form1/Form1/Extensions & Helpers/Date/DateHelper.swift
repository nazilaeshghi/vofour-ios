//
//  DateHelper.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-31.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftDate

enum UserCalendar: String {
    case persian
    case gregorian
}


struct DateHelper {
    
    static func generalDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.calendar = DateHelper.getCurrentCalendar()
        return formatter
    }
    
    static func fullDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy"
        dateFormatter.calendar = DateHelper.getCurrentCalendar()
        dateFormatter.locale = Locale(identifier: "fa_IR")
        return dateFormatter
    }
    
    static func dayInMonthFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.calendar = DateHelper.getCurrentCalendar()
        formatter.locale = Locale(identifier: "fa_IR")
        return formatter
    }
    
    static func monthAndYearFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        formatter.calendar = DateHelper.getCurrentCalendar()
        formatter.locale = Locale(identifier: "fa_IR")
        return formatter
    }
    
    func getHeaderDate(for date: Date) -> String {
        let formatter = DateHelper.monthAndYearFormatter()
        let str = formatter.string(from: date)
        return str
    }
    
    func getRelativeDate(from startDate: Date?, to endDate: Date?) -> String {
        let formatter = DateHelper.dayInMonthFormatter()
        guard let startDate = startDate, let endDate = endDate else { return "" }
        return  "از" + " " + formatter.string(from: startDate) + " " + "تا" + " " + formatter.string(from: endDate)
    }
    
    func getFullDatestring(from date: Date = Date()) -> String {
        let monthString = DateHelper.fullDateFormatter().string(from: date).convertToPersian()
        return monthString
    }
}

extension DateHelper {
    
    static func getDate(hour: Int, minute: Int) -> Date {
        let builtDate = DateInRegion(components: {
            $0.year = Date().year
            $0.month = Date().month
            $0.day = Date().day
            $0.hour = hour
            $0.minute = minute
        }, region: .current)
        return builtDate?.date ?? Date()
    }
    
    static func change(date: Date, hour: Int, minute: Int) -> Date {
        var modifiedDate = DateInRegion(components: {
            $0.year = date.year
            $0.month = date.month
            $0.day = date.day
            $0.hour = hour
            $0.minute = minute
        }, region: .current)
        return modifiedDate?.date ?? Date()
    }
    
    static func setDateRegion() {
        let myRegion = Region(calendar: DateHelper.getCurrentCalendar(),
                              zone: Zones.current,
                              locale: Locales.persian)
        SwiftDate.defaultRegion = myRegion
    }
    
    static func getCurrentCalendar() -> Calendar {
        let calendarName = DateHelper.getCurrentCalendarEnum()
        switch calendarName {
        case .persian:
            return DateHelper.getPersinaCalendar()
        case .gregorian:
            return DateHelper.getGeorgianCalendar()
        }
    }
    
    static func getCurrentStartWeekDay() -> Int {
        if let startDate = UserDefaults.standard.value(forKey: "currentWeekStartDay") as? Int {
            return startDate
        }
        else {
            UserDefaults.standard.set(7, forKey: "currentWeekStartDay")
            return 7
        }
    }
    
    static func changeCurrentWeekStartDayTo(selected: Int) {
        UserDefaults.standard.set(selected, forKey: "currentWeekStartDay")
    }
    
    static func changeCurrentCalenterTo(selected: UserCalendar) {
        UserDefaults.standard.set(selected.rawValue, forKey: "currentCalendar")
    }
    
    static func getCurrentCalendarEnum() -> UserCalendar {
        if let calendarNameStr = UserDefaults.standard.value(forKey: "currentCalendar") as? String,
           let calendarName = UserCalendar(rawValue: calendarNameStr)
        {
            return calendarName
        }
        else {
            UserDefaults.standard.set(UserCalendar.persian.rawValue, forKey: "currentCalendar")
            return .persian
        }
    }
    
    private static func getPersinaCalendar() -> Calendar {
        var pCalendar = Calendar.init(identifier: .persian)
        pCalendar.locale = Locale(identifier: "fa_IR")
        pCalendar.firstWeekday = DateHelper.getCurrentStartWeekDay()
        return pCalendar
    }
    
    private static func getGeorgianCalendar() -> Calendar {
        var pCalendar = Calendar.init(identifier: .gregorian)
        pCalendar.locale = Locale(identifier: "fa_IR")
        pCalendar.firstWeekday = DateHelper.getCurrentStartWeekDay()
        return pCalendar
    }
    
    func getDatesBetween(startDate: Date, endDate: Date, weekDays: [WeekDayObject]) -> [Date] {
        let startDateInRange = DateInRegion(startDate, region: SwiftDate.defaultRegion)
        let endDateInRange = DateInRegion(endDate, region: SwiftDate.defaultRegion)
        
        var outputDates = [Date]()
        for day in weekDays {
            let dates = DateInRegion.datesForWeekday(day.weekDay, from: startDateInRange, to: endDateInRange).map { $0.date }
            outputDates.append(contentsOf: dates)
        }
        return outputDates
    }
}
