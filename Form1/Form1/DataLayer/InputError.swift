//
//  InputError.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-05.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

enum InputError {
    case activityTitle
    case endDate
    case duplicateGoal
    case missingReminder
    
    var localizedValue: String {
        switch self {
        case .activityTitle:
            return LocalizedString.Input.titleError
        case .endDate:
            return LocalizedString.Input.endDateError
        case .duplicateGoal:
            return LocalizedString.Input.duplicateGoalError
        case .missingReminder:
            return LocalizedString.Input.reminderError
        }
    }
}
