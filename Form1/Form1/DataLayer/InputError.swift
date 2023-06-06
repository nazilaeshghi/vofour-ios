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
    
    var localizedValue: String {
        switch self {
        case .activityTitle:
            return LocalizedString.Input.titleError
        case .endDate:
            return LocalizedString.Input.endDateError
        }
    }
}
