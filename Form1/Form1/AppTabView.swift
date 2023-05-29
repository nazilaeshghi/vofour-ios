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
    @State private var tabbarSelection: TabBarItem = .week
    @State private var showingSheet = false
    
    var body: some View {
        CustomTabbarContainerView(selection: $tabbarSelection) {
            AppCoordinator.shared.makeWeekView()
            
                .tabBatItem(tab: .week, selection: $tabbarSelection)
            AppCoordinator.shared.makeContextListView()
                .tabBatItem(tab: .contexts, selection: $tabbarSelection)
            
            AddViewEmptyView()
                .tabBatItem(tab: .add, selection: $tabbarSelection)
            
            AppCoordinator.shared.makeGoalsListView()
                .tabBatItem(tab: .goals, selection: $tabbarSelection)
            
            AddViewEmptyView()
                .tabBatItem(tab: .report, selection: $tabbarSelection)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

struct AddViewEmptyView: View {
    var body: some View {
        Text("در دست احداث")
            .applyStyle(style: .primaryTitle)
    }
}
