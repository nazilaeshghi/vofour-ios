//
//  WeekDayObject.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftDate

struct WeekDayObject {
    let index: Int
    let name: String
    var selected: Bool
    var id: String
}

extension WeekDayObject {
    var getFullTitle: String {
        switch self.id {
        case "week_day_1":
            return LocalizedString.Setting.saturday
        case "week_day_2":
            return LocalizedString.Setting.sunday
        case "week_day_3":
            return LocalizedString.Setting.monday
        case "week_day_4":
            return LocalizedString.Setting.tuesday
        case "week_day_5":
            return LocalizedString.Setting.wednesday
        case "week_day_6":
            return LocalizedString.Setting.thursday
        case "week_day_7":
            return LocalizedString.Setting.friday
        default:
            return ""
        }
    }
}

struct HeaderDayObject {
    let index: Int
    let title: String
    var selected: Bool
    let id: String
    let date: Date
    let obj: WeekDayObject
}

struct DurationObject: Identifiable {
    let tag: Int
    let id: String
    let amount: TimeInterval
}

struct TimeObject: Identifiable {
    let id: String
    var hour: Int
    var minute: Int
    var representingString: String {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        return "\(String(withInt: hour)):\(String(withInt: minute))"
    }
    
    static func createObject() -> TimeObject {
        return TimeObject(id: UUID().uuidString, hour: 9, minute: 0)
    }
}

struct DateBuilder {
    static func buildWeekDays() -> [WeekDayObject] {
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
    
    static func make7Days(selectedDate: Date) -> [HeaderDayObject] {
        let pCalendar = DateHelper.getCurrentCalendar()
        let days = pCalendar.daysWithSameWeekOfYear(as: selectedDate)
        let solid7Days = buildWeekDays()
        let sevenDays = days.enumerated().compactMap { dayEnum -> HeaderDayObject? in
            let simplifiedDate = dayEnum.element.getSimpleDate()
            let dateID = simplifiedDate.getWeekDayID()
            if let foundDate = solid7Days.filter({ $0.id == dateID}).first {
                let strDate = String(pCalendar.component(.day, from: dayEnum.element))
                let selected = simplifiedDate == selectedDate.getSimpleDate()
                return HeaderDayObject(index: dayEnum.offset,
                                       title: strDate.convertToPersian(),
                                       selected: selected,
                                       id: "day_\(dayEnum.offset)",
                                       date: simplifiedDate,
                                       obj: foundDate)
            } else { return nil }
        }
        return sevenDays
    }
}

extension WeekDayObject {
    var weekDay: WeekDay {
        switch self.id {
        case "week_day_1":
            return .saturday
        case "week_day_2":
            return .sunday
        case "week_day_3":
            return .monday
        case "week_day_4":
            return .tuesday
        case "week_day_5":
            return .wednesday
        case "week_day_6":
            return .thursday
        case "week_day_7":
            return .friday
        default:
            return .sunday
        }
    }
}
