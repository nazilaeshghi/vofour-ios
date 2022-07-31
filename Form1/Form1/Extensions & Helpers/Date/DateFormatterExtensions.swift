//
//  DateFormatterExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-31.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension DateFormatter {
    func optionalDate(from date: String?) -> Date? {
        guard let newDate = date else { return nil }
        return self.date(from: newDate)
    }
}
