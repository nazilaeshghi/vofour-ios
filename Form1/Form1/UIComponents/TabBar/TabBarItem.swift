//
//  TabBarItem.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

enum TabBarItem: Hashable {
    case week, contexts, report, add, goals
    
    var iconName: String {
        switch self {
        case .week:
            return "weekDeselectedTabbar"
        case .contexts:
            return "contextDeselectedTabbar"
        case .add:
            return "addTabbar"
        case .goals:
            return "targetsDeselectedTabbar"
        case .report:
            return "reportDeselectedTabbar"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .week:
            return "weekSelectedTabbar"
        case .contexts:
            return "contextSelectedTabbar"
        case .add:
            return "addTabbar"
        case .goals:
            return "targetsSelectedTabbar"
        case .report:
            return "reportDeselectedTabbar"
        }
    }
    
    var title: String {
        switch self {
        case .week:
            return LocalizedString.Tabbar.week
        case .contexts:
            return LocalizedString.Tabbar.contexts
        case .add:
            return ""
        case .goals:
            return LocalizedString.Tabbar.goals
        case .report:
            return LocalizedString.Tabbar.report
        }
    }
    
    
    var tag: Int {
        switch self {
        case .week:
            return 0
        case .contexts:
            return 1
        case .add:
            return 2
        case .goals:
            return 3
        case .report:
            return 4
        }
    }
}
