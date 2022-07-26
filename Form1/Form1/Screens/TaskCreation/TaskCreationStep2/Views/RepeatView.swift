//
//  RepeatView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-05.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct RepeatView: View {
    @Binding var weekDays: [WeekDayObject]
    @Binding var repeatNum: Int
    
    var body: some View {
        VStack (spacing: 24) {
            WeekDaysView(weekDays: $weekDays)
            ChangeRepeatView(repeatNum: $repeatNum, title: LocalizedString.Input.numberOfRepeatTitle)
        }
    }
}

struct RepeatView_Previews: PreviewProvider {
    static var previews: some View {
        RepeatView(weekDays: .constant(DateBuilder.buildWeekDays()), repeatNum: .constant(1))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
