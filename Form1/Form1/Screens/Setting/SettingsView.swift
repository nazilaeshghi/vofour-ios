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
    
    init() {
        persianCalendarIsOn = DateHelper.getCurrentCalendarEnum() == .persian ? true : false
    }
    var body: some View {
        VStack {
            Toggle("Persian Calendar", isOn: $persianCalendarIsOn)
                .onChange(of: persianCalendarIsOn) { newValue in
                    DateHelper.changeCurrentCalenterTo(selected: newValue == true ? .persian : .gregorian)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
            
            VStack {
                Button("شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 7)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("یکشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 1)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("دوشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 2)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("سه‌شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 3)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("چهارشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 4)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("پنج شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 5)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
                Button("جمعه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 6)
                    NotificationCenter.sendNotification(for: .dataChange)
                }
                .padding()
            }
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
