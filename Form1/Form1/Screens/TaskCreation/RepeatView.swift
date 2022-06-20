//
//  RepeatView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-05.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct RepeatView: View {
    var body: some View {
        VStack (spacing: 24) {
            WeekDaysView()
            ChangeRepeatView(numberRelativeText: "ا بار")
        }
    }
}

struct RepeatView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatView()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
