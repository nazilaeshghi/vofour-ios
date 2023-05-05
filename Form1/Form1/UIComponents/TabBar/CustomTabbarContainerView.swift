//
//  CustomTabbarContainerView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomTabbarContainerView<Content: View>: View {
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    @State private var showTabbar: Bool = true
    
    public init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }

    var body: some View {
        VStack(spacing: .zero) {
            ZStack {
                content
            }
            //Spacer()
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferences.self) { value in
            self.tabs = value
        }
    }
}

struct CustomTabbarContainerView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [ .home, .booklet, .add, .form1,.report ]
    
    static var previews: some View {
        CustomTabbarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}

final class UserData: ObservableObject {
  @Published var showFullScreen = false
}
