//
//  ContentView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            if let homeCoordinator  = HomeCoordinator(context: HomeDestinationContext()),
               let todayCoordinator = TodayCoordinator(context: TodayDestinationContext())
            {
                homeCoordinator
                    .destinationView
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                todayCoordinator
                    .destinationView
                    .tabItem {
                        Image(systemName: "calendar")
                        Text("Today")
                    }

            }
        }
    }
}

struct FTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
