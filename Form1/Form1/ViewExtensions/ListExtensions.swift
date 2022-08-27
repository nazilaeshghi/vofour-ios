//
//  ListExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension List {
    func applyListBasicStyle() -> some View {
        self
            .background(Color.background)
            .listStyle(PlainListStyle())
            .onAppear(perform: {
                UIScrollView.appearance().keyboardDismissMode = .interactive
            })
    }
}
