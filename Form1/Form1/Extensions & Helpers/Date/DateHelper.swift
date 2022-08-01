//
//  DateHelper.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-31.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

enum UserCalendar: String {
    case persian
    case gregorian
}


struct DateHelper {
    
    static let fullDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.calendar = DateHelper.getCurrentCalendar()
        return formatter
    }()
    
    func getHeaderDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.calendar = DateHelper.getCurrentCalendar()
        formatter.locale = Locale(identifier: "fa_IR")
        
        if date.getSimpleDate() == Date().getSimpleDate() {
            let str = LocalizedString.Date.today + " " + formatter.string(from: date)
            return str
        } else {
            let str = formatter.string(from: date)
            return str
        }
    }
    
    func getPersianRelativeDate(from startDate: Date?, to endDate: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.calendar = DateHelper.getCurrentCalendar()
        formatter.locale = Locale(identifier: "fa_IR")
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
