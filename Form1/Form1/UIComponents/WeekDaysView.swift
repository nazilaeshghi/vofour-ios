//
//  WeekDaysView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct WeekDaysView: View {
    @Binding var weekDays: [WeekDayObject]
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(LocalizedString.Input.whichDays)
                    .applyStyle(style: .sectionHeaderStyle)
                Spacer()
            }
            
            HStack(spacing: 10) {
                    ForEach(weekDays, id: \.id) { day in
                        if day.selected {
                            Button {
                                weekDays[day.index].selected = !day.selected
                            } label: {
                                Text(day.name)
                                    .applyStyle(style: .buttonTitleStyle)
                            }
                            .applyNoPaddingStyle(style: .multiplePrimary)
                            .frame(width: 38, height: 38)
                            .background(PublicTheme.primaryColor)
                            .cornerRadius(19)
                        } else {
                            Button {
                                weekDays[day.index].selected = !day.selected
                            } label: {
                                Text(day.name)
                                    .applyStyle(style: .deselectedButtonTitleStyle)
                            }
                            .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                            .frame(width: 38, height: 38)
                            .background(.white)
                            .cornerRadius(19)
                            .overlay(
                                RoundedRectangle(cornerRadius: 19)
                                    .stroke(Color(hex: "#d9e0e9"), lineWidth: 1)
                            )
                        }
                    }
            }
        }
    }
}

struct WeekDaysView_Previews: PreviewProvider {
    static var previews: some View {

        WeekDaysView(weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        
        WeekDaysView(weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
        WeekDaysView(weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))

    }
}
