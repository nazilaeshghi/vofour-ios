//
//  TaskHeaderView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-25.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct WeekHeaderView: View {
    @Binding var sevenDays: [HeaderDayObject]
    @Binding var selectedDate: Date
    @Binding var showDatePicker: Bool
    
    var todayProgressString: String
    var weekProgressString: String
    var todayProgress: Float
    var weekProgress: Float
    
    let circleSize: CGFloat = PublicTheme.circleSize
    let headerHeight: CGFloat = 40
    @State private var showingSetting = false
    
    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace2) {
            // Selected date and week progress
            HStack(alignment: .center) {
                Button {
                    showingSetting = true
                } label: {
                    Image("settings")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .tint(Color.primaryTextColor)
                }

                Button {
                    showDatePicker = true
                } label: {
                    HStack {
                        Text(DateHelper().getHeaderDate(for: selectedDate))
                            .applyStyle(style: .regularMediumTitle)
                        Image("ArrowDown")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                
                Spacer()
                
                HStack() {
                    VStack(spacing: -5) {
                        HStack {
                            Text(weekProgressString)
                                .applyStyle(style: .primaryRegularBody)
                            Text(LocalizedString.Date.week)
                                .applyStyle(style: .regularBody)
                        }
                        HStack {
                            Text(todayProgressString)
                                .applyStyle(style: .greenRegularBody)
                            Text(LocalizedString.Date.today)
                                .applyStyle(style: .regularBody)
                        }
                    }
                    WeekCircleView(todayProgress: todayProgress,
                                   weekProgress: weekProgress)

                }
            }
            .frame(height: headerHeight)
            
            VStack(spacing: 2){
                // Day titles in week
                HStack {
                    ForEach(sevenDays, id: \.id) { item in
                        Text(item.obj.name)
                            .applyStyle(style: .headerMediumSubtitle)
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .center
                    )
                }
                
                // Dates in a week
                HStack {
                    ForEach(sevenDays, id: \.id) { day in
                        if day.date.isToday {
                            Button {
                                selectDay(index: day.index)
                            } label: {
                                Text(day.title)
                                    .applyStyle(style: .brightRegularTitle)
                                    .background(.clear)
                            }
                            .frame(width: circleSize, height: circleSize)
                            .background(Color.greenColor)
                            .cornerRadius(circleSize/2)
                        }
                        else {
                            if day.date == selectedDate {
                                Button {
                                    selectDay(index: day.index)
                                } label: {
                                    Text(day.title)
                                        .applyStyle(style: .regularTitle)
                                        .background(.clear)
                                }
                                .frame(width: circleSize, height: circleSize)
                                .overlay(
                                    RoundedRectangle(cornerRadius: circleSize/2)
                                        .stroke(Color.primaryTextColor, lineWidth: 1)
                                )
                                
                            }
                            else {
                                Button {
                                    selectDay(index: day.index)
                                } label: {
                                    Text(day.title)
                                        .applyStyle(style: .regularTitle)
                                        .background(Color.background)
                                }
                                .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                                .frame(width: circleSize, height: circleSize)
                                .background(.clear)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
        }
        .sheet(isPresented: $showingSetting, onDismiss: {
            showingSetting = false
        }) {
            SettingsView(isPresented: $showingSetting)
                .environment(\.layoutDirection, .rightToLeft)
        }
        .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
            sevenDays = DateBuilder.make7Days(selectedDate: selectedDate)
        }
    }
    
    func selectDay(index: Int) {
        sevenDays[index].selected = true
        resetOtherDays(except: index)
        selectedDate = sevenDays[index].date
    }
    
    func resetOtherDays(except index: Int) {
        for i in 0 ..< sevenDays.count {
            if index != i {
                sevenDays[i].selected = false
            }
        }
    }
}

struct TaskHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        let date = Date().dateByAdding(-1, .day).date
        WeekHeaderView(sevenDays: .constant(DateBuilder.make7Days(selectedDate: Date())),
                       selectedDate: .constant(date),
                       showDatePicker: .constant(false),
                       todayProgressString: "%۲۱",
                       weekProgressString: "%۲۵",
                       todayProgress: 0.2,
                       weekProgress: 0.4)
        .environment(\.layoutDirection, .rightToLeft)
        .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
