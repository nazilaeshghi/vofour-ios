//
//  DatePickerInputView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-17.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI
import RealmSwift

struct CalendarSheetView: View {
    @Binding var presented: Bool
    @Binding var dateStr: String?
    @State var calendarDate: Date
    var title: String
    
    init(presented: Binding<Bool>, dateString: Binding<String?>, title: String) {
        _presented = presented
        _dateStr = dateString
        self.title = title
        _calendarDate = State(initialValue: Globals.dateFormatter.optionalDate(from: dateString.wrappedValue) ?? Date())
    }
    
    var body: some View {
        VStack {
            ModalHeaderView(title: LocalizedString.Input.startDateSelectoreTitle) {
                presented = false
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            
            DatePicker("", selection: $calendarDate, displayedComponents: [.date])
                .datePickerStyle(.graphical)
                .environment(\.calendar, Globals.getPersinaCalendar())
                .environment(\.locale, Locale.init(identifier: "fa"))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Button {
                presented = false
                dateStr = Globals.dateFormatter.string(from: calendarDate)
            } label: {
                Spacer()
                Text(LocalizedString.Buttons.saveTitle)
                    .applyStyle(style: .buttonTitleStyle)
                Spacer()
            }
            .applyStyle(style: .multiplePrimary)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
            
            Spacer()
        }
    }
}
