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
    @Binding var endDateError: InputError?
    
    var body: some View {
        VStack(spacing: PublicTheme.vSpace) {
            SelectorInputCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.defaultSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInputCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.defaultSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle,
                              error: $endDateError)
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
    @Binding var endDateError: InputError?
    
    var body: some View {
        VStack(spacing: PublicTheme.vSpace) {
            SelectorInputCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.defaultSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInputCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.defaultSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle,
                              error: $endDateError)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
            
            ChangeRepeatView(repeatNum: $repeatNum, title: LocalizedString.QuitHabitStep2.numberOfRepeatTitle)
        }
    }
}
