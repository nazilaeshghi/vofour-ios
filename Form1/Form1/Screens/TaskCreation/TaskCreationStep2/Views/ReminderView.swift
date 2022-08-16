//
//  ReminderView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-16.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ReminderView: View {
    @Binding var needReminder: Int
    @Binding var reminders: [TimeObject]
    @State private var timePresented = false
    @State private var selectedTimeID: String = "0"

    var body: some View {
        VStack {
            SegmentedPicker(items: [LocalizedString.TaskCreationStep2.dontNeedReminder,
                                    LocalizedString.TaskCreationStep2.needReminder],
                            selection: $needReminder)
            if needReminder == 1 {
                VStack {
                    ForEach($reminders, id: \.id) { reminder in
                        ReminderCellView(time: reminder) {
                            self.reminders.removeAll(where: {$0.id == reminder.id})
                        }
                        .onTapGesture {
                            selectedTimeID = reminder.id
                            timePresented = true
                        }
                    }
                    
                    AddReminderCellView()
                        .onTapGesture {
                            reminders.append(TimeObject.createObject())
                        }
                }
            }
        }
        .sheet(isPresented: $timePresented, content: {
            if let selectedTime = $reminders.first(where: {$0.id == selectedTimeID}) {
                ReminerSheet(presented: $timePresented, timeObj: selectedTime)
            }
        })

    }
}
