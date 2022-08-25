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
    let circleSize: CGFloat = PublicTheme.circleSize
    
    var body: some View {
        VStack(spacing: PublicTheme.inputCellSpacing) {
            HStack {
                Text(LocalizedString.Input.whichDays)
                    .applyStyle(style: .sectionHeaderStyle)
                Spacer()
            }
            
            HStack(spacing: PublicTheme.miniCollectionSpace) {
                    ForEach(weekDays, id: \.id) { day in
                        if day.selected {
                            Button {
                                weekDays[day.index].selected = !day.selected
                            } label: {
                                Text(day.name)
                                    .applyStyle(style: .buttonTitleStyle)
                            }
                            .applyNoPaddingStyle(style: .multiplePrimary)
                            .frame(width: circleSize, height: circleSize)
                            .background(PublicTheme.primaryColor)
                            .cornerRadius(circleSize/2)
                        } else {
                            Button {
                                weekDays[day.index].selected = !day.selected
                            } label: {
                                Text(day.name)
                                    .applyStyle(style: .deselectedButtonTitleStyle)
                            }
                            .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                            .frame(width: circleSize, height: circleSize)
                            .background(.white)
                            .cornerRadius(circleSize/2)
                            .overlay(
                                RoundedRectangle(cornerRadius: circleSize/2)
                                    .stroke(PublicTheme.borderColor, lineWidth: 1)
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
