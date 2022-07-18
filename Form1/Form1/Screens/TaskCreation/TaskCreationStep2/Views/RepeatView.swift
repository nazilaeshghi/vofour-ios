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
        RepeatView(weekDays: .constant(WeekDayBuilder.build()), repeatNum: .constant(1))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

struct WeekDayObject {
    let index: Int
    let name: String
    var selected: Bool
    let id: String
}

struct WeekDayBuilder {
    static func build() -> [WeekDayObject] {
        return 
            [
                WeekDayObject(index: 0, name: "ش", selected: true, id: "week_day_1"),
                WeekDayObject(index: 1, name: "ی", selected: true, id: "week_day_2"),
                WeekDayObject(index: 2, name: "د", selected: true, id: "week_day_3"),
                WeekDayObject(index: 3, name: "س", selected: true, id: "week_day_4"),
                WeekDayObject(index: 4, name: "چ", selected: true, id: "week_day_5"),
                WeekDayObject(index: 5, name: "پ", selected: true, id: "week_day_6"),
                WeekDayObject(index: 6, name: "ج", selected: true, id: "week_day_7")
            ]
    }
}
