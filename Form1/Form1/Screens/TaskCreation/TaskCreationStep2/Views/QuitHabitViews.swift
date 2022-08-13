//
//  QuitHabitViews.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-13.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct QuitEntirelyView: View {
    var startDateText: String?
    var endDateText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
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
        }
    }
}

struct QuitWithLimitView: View {
    @Binding var repeatNum: Int
    var startDateText: String?
    var endDateText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
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
            
            ChangeRepeatView(repeatNum: $repeatNum, title: LocalizedString.QuitHabitStep2.numberOfRepeatTitle)
        }
    }
}
