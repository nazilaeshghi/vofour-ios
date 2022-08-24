//
//  ActivityCreationViews.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-13.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationViewNonRepeatitive: View {
    var dateText: String?
    var durationText: String?
    @Binding var startDateCalendarPresented: Bool
    @Binding var durationPresented: Bool
    
    var body: some View {
        VStack(spacing: PublicTheme.vSpace){
            SelectorInoutCell(text: dateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.dateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: durationText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
                }
        }
    }
}

struct TaskCreationViewRepeatitive: View {
    @Binding var repeatNum: Int
    @Binding var weekDays: [WeekDayObject]
    
    var startDateText: String?
    var endDateText: String?
    var durationText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    @Binding var durationPresented: Bool
    
    var body: some View {
        VStack (spacing: PublicTheme.vSpace) {
            SelectorInoutCell(text: durationText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
                }
            
            SelectorInoutCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
            RepeatView(weekDays: $weekDays, repeatNum: $repeatNum)
        }
    }
}
