//
//  ContentView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct AppTabView: View {
    @State var selection = 0
    @State private var tabbarSelection: TabBarItem = .home
    @State private var showingSheet = false
    
    var body: some View {
        CustomTabbarContainerView(selection: $tabbarSelection) {
            
            if let homeCoordinator  = HomeCoordinator(context: HomeDestinationContext()),
               let todayCoordinator = TodayCoordinator(context: TodayDestinationContext())
            {
                homeCoordinator
                    .destinationView
                    .tabBatItem(tab: .home, selection: $tabbarSelection)
                
                todayCoordinator
                    .destinationView
                    .tabBatItem(tab: .booklet, selection: $tabbarSelection)
                
                todayCoordinator
                    .destinationView
                    .tabBatItem(tab: .add, selection: $tabbarSelection)
                
                todayCoordinator
                    .destinationView
                    .tabBatItem(tab: .activities, selection: $tabbarSelection)
                
                todayCoordinator
                    .destinationView
                    .tabBatItem(tab: .report, selection: $tabbarSelection)
            }
        }
    }
}

struct FTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
