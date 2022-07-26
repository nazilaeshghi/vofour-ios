//
//  CalendarExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-26.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension Calendar {
    func intervalOfWeek(for date: Date) -> DateInterval? {
        dateInterval(of: .weekOfYear, for: date)
    }
    
    func startOfWeek(for date: Date) -> Date? {
        intervalOfWeek(for: date)?.start
    }
    
    func daysWithSameWeekOfYear(as date: Date) -> [Date] {
        guard let startOfWeek = startOfWeek(for: date) else {
            return []
        }
        
        return (0 ... 6).reduce(into: []) { result, daysToAdd in
            result.append(Calendar.current.date(byAdding: .day, value: daysToAdd, to: startOfWeek))
        }
        .compactMap { $0 }
    }
}
