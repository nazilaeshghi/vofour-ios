//
//  MyCustomTabBarView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct MyCustomTabBarView: View {
    
    @State var selection: Int = 0
    
    var body: some View {
        NavigationView {
            let homeView = AppCoordinator.shared.makeContextListView()
            let taskView = AppCoordinator.shared.makeWeekView()
            TabView {
                
                    homeView
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }
                    
                    taskView
                        .tabItem {
                            Label("Order", systemImage: "square.and.pencil")
                        }
                }
        }
    }
}

struct MyCustomTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MyCustomTabBarView()
    }
}

struct MyTabItem: View {
    @Binding var selection: Int
    let item: TabBarItem
    
    var body: some View {
        VStack {
            Image(selection == 0 ? item.selectedIconName : item.iconName)
            Text(item.title)
                .applyStyle(style: .primaryRegularBody)
        }
    }
}
