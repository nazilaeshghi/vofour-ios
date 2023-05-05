//
//  SettingsView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-30.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var persianCalendarIsOn: Bool
    @State var currentDate: Int
    @Binding var isPresented: Bool
    
    init(isPresented : Binding<Bool>) {
        persianCalendarIsOn = DateHelper.getCurrentCalendarEnum() == .persian ? true : false
        currentDate = DateHelper.getCurrentStartWeekDay()
        _isPresented = isPresented
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Text(LocalizedString.Setting.title)
                    .applyStyle(style: .mediumTitle)
                Spacer()
                Button {
                    isPresented  = false
                } label: {
                    Image.closeIcon
                }
                
            }
            .padding([.top, .bottom], PublicTheme.vHeaderSpace)
            
            HStack {
                Text(LocalizedString.Setting.currentCalendarTitle)
                    .applyStyle(style: .primaryTitle)
                
                Spacer()
                
                Toggle("", isOn: $persianCalendarIsOn)
                    .tint(Color.primaryColor)
                    .onChange(of: persianCalendarIsOn) { newValue in
                        DateHelper.changeCurrentCalenterTo(selected: newValue == true ? .persian : .gregorian)
                        NotificationCenter.sendNotification(for: .dataChange)
                    }
                    .padding(.bottom, 10)
            }
                        
            VStack(alignment: .leading, spacing: 5) {
                Text(LocalizedString.Setting.startDate)
                    .applyStyle(style: .mediumTitle)
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 7)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 7
                } label: {
                    Image(currentDate == 7 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.saturday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 1)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 1
                } label: {
                    Image(currentDate == 1 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.sunday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button() {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 2)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 2
                } label: {
                    Image(currentDate == 2 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.monday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 3)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 3
                } label: {
                    Image(currentDate == 3 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.tuesday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 4)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 4
                } label: {
                    Image(currentDate == 4 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.wednesday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 5)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 5
                } label: {
                    Image(currentDate == 5 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.thursday)
                        .applyStyle(style: .primaryTitle)
                    
                }
                
                Button {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 6)
                    NotificationCenter.sendNotification(for: .dataChange)
                    currentDate = 6
                } label: {
                    Image(currentDate == 6 ? "Activated_on": "Activated_off")
                           .renderingMode(.original)
                           .padding(0)
                    Text(LocalizedString.Setting.friday)
                        .applyStyle(style: .primaryTitle)
                    
                }
            }
            
            Spacer()
            HStack {
                Spacer()
                Text(LocalizedString.Setting.us)
                    .applyStyle(style: .greenRegularBody)
                Spacer()
            }
        }
        .applyBasicViewStyle()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: .constant(true))
    }
}
