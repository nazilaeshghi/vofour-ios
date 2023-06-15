//
//  WeekDaysView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct WeekDaysView: View {
    let title: String
    @Binding var weekDays: [WeekDayObject]
    let circleSize: CGFloat = PublicTheme.circleSize
    
    var body: some View {
        VStack(spacing: PublicTheme.inputCellSpacing) {
            HStack {
                Text(title)
                    .applyStyle(style: .mediumSubtitle)
                Spacer()
            }
            
            HStack(spacing: PublicTheme.miniCollectionSpace) {
                ForEach(weekDays, id: \.id) { day in
                    if day.selected {
                        Button {
                            weekDays[day.index].selected = !day.selected
                        } label: {
                            Text(day.name)
                                .applyStyle(style: .brightRegularTitle)
                        }
                        .applyNoPaddingStyle(style: .multiplePrimary)
                        .frame(width: circleSize, height: circleSize)
                        .background(Color.primaryColor)
                        .cornerRadius(circleSize/2)
                    } else {
                        Button {
                            weekDays[day.index].selected = !day.selected
                        } label: {
                            Text(day.name)
                                .applyStyle(style: .regularTitle)
                        }
                        .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                        .frame(width: circleSize, height: circleSize)
                        .background(.white)
                        .cornerRadius(circleSize/2)
                        .overlay(
                            RoundedRectangle(cornerRadius: circleSize/2)
                                .stroke(Color.borderColor, lineWidth: 1)
                        )
                    }
                }
            }
        }
    }
}

struct SingleSelectWeekDaysView: View {
    let title: String
    let weekDays: [WeekDayObject] = DateBuilder.buildWeekDays()
    let circleSize: CGFloat = PublicTheme.circleSize
    @Binding var currentIndex: Int
    
    var body: some View {
        VStack(spacing: PublicTheme.inputCellSpacing) {
            HStack {
                Text(title)
                    .applyStyle(style: .regularSubtitle)
                Spacer()
            }
            
            HStack(spacing: PublicTheme.miniCollectionSpace) {
                ForEach(weekDays, id: \.id) { day in
                    if day.index == currentIndex {
                        Button {
                            currentIndex = day.index
                        } label: {
                            Text(day.name)
                                .applyStyle(style: .brightRegularTitle)
                        }
                        .applyNoPaddingStyle(style: .multiplePrimary)
                        .frame(width: circleSize, height: circleSize)
                        .background(Color.primaryColor)
                        .cornerRadius(circleSize/2)
                    } else {
                        Button {
                            currentIndex = day.index
                        } label: {
                            Text(day.name)
                                .applyStyle(style: .regularTitle)
                        }
                        .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                        .frame(width: circleSize, height: circleSize)
                        .background(.white)
                        .cornerRadius(circleSize/2)
                        .overlay(
                            RoundedRectangle(cornerRadius: circleSize/2)
                                .stroke(Color.borderColor, lineWidth: 1)
                        )
                    }
                }
            }
        }
    }
}

struct WeekDaysView_Previews: PreviewProvider {
    static var previews: some View {

        WeekDaysView(title: "چه روز‌هایی", weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        
        WeekDaysView(title: "چه روز‌هایی", weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
        WeekDaysView(title: "چه روز‌هایی", weekDays: .constant(DateBuilder.buildWeekDays()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))

    }
}
