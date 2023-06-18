//
//  SettingsView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-30.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Injected(\.localNotificationProvider) var notificationProvider: NotificationManagable

    @State var persianCalendarIsOn: Int
    @State var weekStartDayIndex: Int
    @Binding var isPresented: Bool
    @State var notificationState: NotificationState
    @State var notificationIsOn: Bool
    
    init(isPresented : Binding<Bool>) {
        persianCalendarIsOn = DateHelper.getCurrentCalendarEnum() == .persian ? 0 : 1
        weekStartDayIndex = DateHelper.getCurrentStartWeekDay()
        _isPresented = isPresented
        notificationState = LocalNotificationManager().getNotificationState()
        notificationIsOn = SettingHelper.isNotificationON()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            makeHeader()

            VStack(alignment: .leading, spacing: SpaceType.inlineForm.value) {
                makeCalenderSection()
                makeFirstDaySection()
                //makeNotificationSection()
                Spacer()
                makeCreditSection()
            }
            .applyBasicViewStyle()
        }
        .applyBackgroundColor()
    }
    
    @ViewBuilder
    func makeCreditSection() -> some View {
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
    
    @ViewBuilder
    func makeCalenderSection() -> some View  {
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
    }
    
    @ViewBuilder
    func makeHeader() -> some View {
        VerticalSpaceView(space: .modalHeader)
        ModalHeaderView(title: LocalizedString.Setting.title) { isPresented  = false }
        VerticalSpaceView(space: .header)
    }
    
    @ViewBuilder
    func makeFirstDaySection() -> some View {
        SingleSelectWeekDaysView(title: LocalizedString.Setting.startDate, currentIndex: $weekStartDayIndex)
            .onChange(of: weekStartDayIndex) { newValue in
                DateHelper.changeCurrentWeekStartDayTo(selected: newValue)
                NotificationCenter.sendNotification(for: .dataChange)
            }
    }
    
    @ViewBuilder
    func makeNotificationSection() -> some View {
        VStack {
            Divider()
            VerticalSpaceView(space: .header)
            HStack {
                Text(LocalizedString.Setting.notificationTitle)
                    .applyStyle(style: .regularSubtitle)
                Spacer()
                
                Text(notificationState.localizedString)
                    .applyStyle(style: .regularSubtitle)
                
                Toggle("", isOn: $notificationIsOn)
                    .tint(Color.primaryColor)
                    .onChange(of: notificationIsOn) { newValue in
                        SettingHelper.changeNotificationStateTo(selected: newValue)
                    }
                    .toggleStyle(ColoredToggleStyle())
                    .frame(width: 36)
                    .frame(height: 20)
                    .padding(.trailing, 8)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
            .environment(\.layoutDirection, .rightToLeft)
    }
}
