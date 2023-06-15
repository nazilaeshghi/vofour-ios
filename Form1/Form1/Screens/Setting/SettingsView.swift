//
//  SettingsView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-30.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var persianCalendarIsOn: Int
    @State var currentDate: Int
    @Binding var isPresented: Bool
    
    init(isPresented : Binding<Bool>) {
        persianCalendarIsOn = DateHelper.getCurrentCalendarEnum() == .persian ? 0 : 1
        currentDate = DateHelper.getCurrentStartWeekDay()
        _isPresented = isPresented
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VerticalSpaceView(space: .modalHeader)
            ModalHeaderView(title: LocalizedString.Setting.title) { isPresented  = false }
            
            VerticalSpaceView(space: .header)
            VStack(alignment: .leading, spacing: SpaceType.inlineForm.value) {
                VStack(spacing: 6) {
                    HStack {
                        Text(LocalizedString.Setting.calendarType)
                            .applyStyle(style: .regularSubtitle)
                        Spacer()
                    }
                    
                    SegmentedPicker(items: [LocalizedString.Setting.persianCalendarTitle,
                                            LocalizedString.Setting.georgianCalendarTitle],
                                    selection: $persianCalendarIsOn)
                    .onChange(of: persianCalendarIsOn) { newValue in
                        DateHelper.changeCurrentCalenterTo(selected: newValue == 0 ? .persian : .gregorian)
                        NotificationCenter.sendNotification(for: .dataChange)
                    }
                }
                
                SingleSelectWeekDaysView(title: LocalizedString.Setting.startDate, currentIndex: $currentDate)
                    .onChange(of: currentDate) { newValue in
                        DateHelper.changeCurrentWeekStartDayTo(selected: newValue)
                        NotificationCenter.sendNotification(for: .dataChange)
                    }
                
                Spacer()
                VStack {
                    Image("heartImg")
                    
                    HStack {
                        Spacer()
                        Text(LocalizedString.Setting.us)
                            .applyStyle(style: .secondaryRegularBody)
                        Spacer()
                    }
                }
            }
            .applyBasicViewStyle()
        }
        .applyBackgroundColor()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
            .environment(\.layoutDirection, .rightToLeft)
    }
}
