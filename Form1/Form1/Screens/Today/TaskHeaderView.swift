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
    
    var body: some View {
        VStack(spacing: 2) {
            HStack {
                ForEach(sevenDays, id: \.id) { item in
                    Text(item.obj.name)
                        .applyStyle(style: .sectionHeaderStyle)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
            }
            
            HStack {
                ForEach(sevenDays, id: \.id) { day in
                    if day.selected {
                        Button {
                            selecDay(index: day.index)
                        } label: {
                            Text(day.title)
                                .applyStyle(style: .buttonTitleStyle)
                                .background(.clear)
                        }
                        .applyNoPaddingStyle(style: .multiplePrimary)
                        .frame(width: 38, height: 38)
                        .background(PublicTheme.primaryColor)
                        .cornerRadius(19)
                    }
                    else {
                        Button {
                            selecDay(index: day.index)
                        } label: {
                            Text(day.title)
                                .applyStyle(style: .deselectedButtonTitleStyle)
                                .background(PublicTheme.background)
                        }
                        .applyNoPaddingWithBorderStyle(style: .multipleDeselectedPrimary)
                        .frame(width: 38, height: 38)
                        .background(.clear)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.settingChange)) { obj in
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
        TaskHeaderView(selectedDate: .constant(Date()))
    }
}
