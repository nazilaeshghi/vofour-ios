//
//  MainTabView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

//struct MainTabView: View {
//    @State var selection = 0
//
//    var body: some View {
//        TabView(selection: $selection) {
//            if let homeCoordinator  = HomeCoordinator(context: HomeDestinationContext()),
//               let tasksView = AppCoordinator.shared.makeTasksView()
//            {
//                homeCoordinator
//                    .destinationView
//                    .tabItem {
//                        Image(selection == 0 ? "homeTabbarSelected" : "homeTabbar")
//                        Text(LocalizedString.Tabbar.home)
//                            .applyStyle(style: .tabbarStyle)
//                    }.tag(0)
//
//                tasksView
//                    .tabItem {
//                        Image(selection == 1 ? "bookletTabbarSelected" : "bookletTabbar")
//                        Text(LocalizedString.Tabbar.booklet)
//                            .applyStyle(style: .tabbarStyle)
//                    }.tag(1)
//
//                tasksView
//                    .tabItem {
//                        Image("addTabbar")
//                        Text(LocalizedString.Tabbar.add)
//                            .applyStyle(style: .tabbarStyle)
//                    }.tag(2)
//                    .offset(y: -10)
//
//                tasksView
//                    .tabItem {
//                        Image(selection == 3 ? "activityTabbarSelected" : "activityTabbar")
//                        Text(LocalizedString.Tabbar.activities)
//                            .applyStyle(style: .tabbarStyle)
//                    }.tag(3)
//
//                tasksView
//                    .tabItem {
//                        Image(selection == 4 ? "reportTabbarSelected" : "reportTabbar")
//                        Text(LocalizedString.Tabbar.report)
//                            .applyStyle(style: .tabbarStyle)
//                    }.tag(4)
//            }
//        }
//        .accentColor(PublicTheme.primaryColor)
//
//    }
//}
