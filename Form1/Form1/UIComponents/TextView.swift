//
//  TextView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-26.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TextView: View {
    let model: LabelDisplayModel
    var body: some View {
        Text(model.plainText)
            .applyStyle(style: model.labelStyle)
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            Text("First")
            Text("Second")
            Text("Third")
            Text("Fourth")
        }
        .tabViewStyle(.page)
    }
}
