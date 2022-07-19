//
//  TabBarItemsPreferences.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TabBarItemsPreferences: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection.tag == tab.tag ? 1.0 : 0.0)
            .preference(key: TabBarItemsPreferences.self, value: [tab])
    }
}

extension View {
    func tabBatItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
