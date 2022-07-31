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

extension Date {
    func getPersianRelativeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.calendar = DateHelper.getCurrentCalendar()
        let monthString = dateFormatter.string(from: self)
        return monthString
    }
}

enum UserCalendar: String {
    case persian
    case gregorian
}

struct DateHelper {
    let formatter: DateFormatter
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.calendar = DateHelper.getCurrentCalendar()
        return formatter
    }()
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.calendar = DateHelper.getCurrentCalendar()
        dateFormatter.locale = Locale(identifier: "fa_IR")
        self.formatter = dateFormatter
    }
    
    func getPersianRelativeDate(for date: Date) -> String {
        if date.getSimpleDate() == Date().getSimpleDate() {
            let str = LocalizedString.Date.today + " " + formatter.string(from: date)
            return str
        } else {
            let str = formatter.string(from: date)
            return str
        }
        
    }
    
    func getPersianRelativeDate(from startDate: Date?, to endDate: Date?) -> String {
        guard let startDate = startDate, let endDate = endDate else { return "" }
        return  "از" + " " + formatter.string(from: startDate) + " " + "تا" + " " + formatter.string(from: endDate)
    }
    
    func getTodayPersianFullDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy"
        dateFormatter.calendar = DateHelper.getCurrentCalendar()
        dateFormatter.locale = Locale(identifier: "fa_IR")
        let monthString = dateFormatter.string(from: Date()).convertToPersian()
        return monthString
    }
}

extension DateHelper {
    
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
}
