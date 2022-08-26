//
//  TaskHeaderView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-25.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskHeaderView: View {
    @State var sevenDays: [HeaderDayObject] = DateBuilder.make7Days(selectedDate: Date())
    @Binding var selectedDate: Date
    var todayProgressString: String
    
    let circleSize: CGFloat = PublicTheme.circleSize
    
    var body: some View {
        VStack(spacing: 2) {
            // Selected date title with progress
            HStack(alignment: .lastTextBaseline) {
                Text(DateHelper().getHeaderDate(for: selectedDate))
                    .applyStyle(style: .mediumTitle)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                Text(todayProgressString)
                    .applyStyle(style: .largTitleWithGreenColor)
            }
            
            // Day titles in week
            HStack {
                ForEach(sevenDays, id: \.id) { item in
                    Text(item.obj.name)
                        .applyStyle(style: .homeHeaderStyle)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
            }
            
            // Dates in week
            HStack {
                ForEach(sevenDays, id: \.id) { day in
                    if day.date.isToday {
                        Button {
                            selecDay(index: day.index)
                        } label: {
                            Text(day.title)
                                .applyStyle(style: .brightButtonTitle)
                                .background(.clear)
                        }
                        .applyNoPaddingStyle(style: .multiplePrimary)
                        .frame(width: circleSize, height: circleSize)
                        .background(Color.primaryColor)
                        .cornerRadius(circleSize/2)
                    }
                    else {
                        if day.selected {
                            Button {
                                selecDay(index: day.index)
                            } label: {
                                Text(day.title)
                                    .applyStyle(style: .deselectedButtonTitleStyle)
                                    .background(.clear)
                            }
                            .frame(width: circleSize, height: circleSize)
                            .background(Color.primaryLightColor)
                            .cornerRadius(circleSize/2)
                        }
                        else {
                            Button {
                                selecDay(index: day.index)
                            } label: {
                                Text(day.title)
                                    .applyStyle(style: .deselectedButtonTitleStyle)
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
        .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
            sevenDays = DateBuilder.make7Days(selectedDate: selectedDate)
        }
    }
    
    func selecDay(index: Int) {
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
        TaskHeaderView(selectedDate: .constant(Date()), todayProgressString: "%۲۱")
    }
}
