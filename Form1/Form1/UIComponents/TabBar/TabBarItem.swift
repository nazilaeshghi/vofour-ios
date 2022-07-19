//
//  TabBarItem.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

enum TabBarItem: Hashable {
    case home, booklet, report, add, activities
    
    var iconName: String {
        switch self {
        case .home:
            return "homeTabbar"
        case .booklet:
            return "bookletTabbar"
        case .report:
            return "reportTabbar"
        case .add:
            return "addTabbar"
        case .activities:
            return "activityTabbar"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .home:
            return "homeTabbarSelected"
        case .booklet:
            return "bookletTabbarSelected"
        case .report:
            return "reportTabbarSelected"
        case .add:
            return "addTabbar"
        case .activities:
            return "activityTabbarSelected"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return LocalizedString.Tabbar.home
        case .booklet:
            return LocalizedString.Tabbar.booklet
        case .report:
            return LocalizedString.Tabbar.report
        case .add:
            return ""
        case .activities:
            return LocalizedString.Tabbar.activities
        }
    }
    
    
    var tag: Int {
        switch self {
        case .home:
            return 0
        case .booklet:
            return 1
        case .report:
            return 4
        case .add:
            return 2
        case .activities:
            return 3
        }
    }
}
