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
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
            
            VStack {
                Button("شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 7)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("یکشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 1)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("دوشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 2)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("سه‌شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 3)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("چهارشنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 4)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("پنج شنبه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 5)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                }
                .padding()
                Button("جمعه") {
                    DateHelper.changeCurrentWeekStartDayTo(selected: 6)
                    NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
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
