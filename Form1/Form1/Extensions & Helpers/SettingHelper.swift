//
//  SettingHelper.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-16.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

struct SettingHelper {
    static func isNotificationON() -> Bool {
        if let state = UserDefaults.standard.value(forKey: "currentNotificationSetting") as? Bool {
            return state
        }
        else {
            UserDefaults.standard.set(true, forKey: "currentNotificationSetting")
            return true
        }
    }
    
    static func changeNotificationStateTo(selected: Bool) {
        UserDefaults.standard.set(selected, forKey: "currentNotificationSetting")
    }
}
