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
    let minDate: String?
    let maxDate: String?
    var title: String
    
    init(presented: Binding<Bool>, dateString: Binding<String?>, title: String, minDate: String? = nil, maxDate: String? = nil) {
        _presented = presented
        _dateStr = dateString
        self.title = title
        _calendarDate = State(initialValue: DateHelper.generalDateFormatter().optionalDate(from: dateString.wrappedValue) ?? Date())
        self.minDate = minDate
        self.maxDate = maxDate
    }
    
    var body: some View {
        VStack {
            ModalHeaderView(title: title) {
                presented = false
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            
            switch(minDate, maxDate) {
            case (nil, nil):
                DatePicker("", selection: $calendarDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.calendar, DateHelper.getCurrentCalendar())
                    .environment(\.locale, Locale.init(identifier: "fa"))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .accentColor(Color.primaryColor)
                    .environment(\.layoutDirection, .rightToLeft)
            case (nil, let maxDateStr):
                let maxDate = DateHelper.generalDateFormatter().optionalDate(from: maxDateStr) ?? Date()
                
                DatePicker("", selection: $calendarDate, in: ...maxDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.calendar, DateHelper.getCurrentCalendar())
                    .environment(\.locale, Locale.init(identifier: "fa"))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .accentColor(Color.primaryColor)
                    .environment(\.layoutDirection, .rightToLeft)
            case (let minDateStr, nil):
                let minDate = DateHelper.generalDateFormatter().optionalDate(from: minDateStr) ?? Date()
                
                DatePicker("", selection: $calendarDate, in: minDate..., displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.calendar, DateHelper.getCurrentCalendar())
                    .environment(\.locale, Locale.init(identifier: "fa"))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .accentColor(Color.primaryColor)
                    .environment(\.layoutDirection, .rightToLeft)
            case (let minDateStr, let maxDateStr):
                let minDate = DateHelper.generalDateFormatter().optionalDate(from: minDateStr) ?? Date()
                let maxDate = DateHelper.generalDateFormatter().optionalDate(from: maxDateStr) ?? Date()

                DatePicker("", selection: $calendarDate, in: minDate...maxDate, displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .environment(\.calendar, DateHelper.getCurrentCalendar())
                    .environment(\.locale, Locale.init(identifier: "fa"))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .accentColor(Color.primaryColor)
                    .environment(\.layoutDirection, .rightToLeft)
            }
            
            
            
            Button {
                presented = false
                dateStr = DateHelper.generalDateFormatter().string(from: calendarDate)
            } label: {
                Spacer()
                Text(LocalizedString.Buttons.saveTitle)
                    .applyStyle(style: .brightRegularTitle)
                Spacer()
            }
            .applyStyle(style: .multiplePrimary)
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
            
            Spacer()
        }
    }
}
