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
            
            if let homeView = AppCoordinator.shared.makeHomeView(),
               let taskView = AppCoordinator.shared.makeTasksView()
            {
                homeView
                    .tabBatItem(tab: .home, selection: $tabbarSelection)
                
                taskView
                    .tabBatItem(tab: .booklet, selection: $tabbarSelection)
                
                taskView
                    .tabBatItem(tab: .add, selection: $tabbarSelection)
                
                taskView
                    .tabBatItem(tab: .activities, selection: $tabbarSelection)
                
                taskView
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
