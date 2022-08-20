//
//  ReminerSheet.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-16.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI
import SwiftDate

struct ReminerSheet: View {
    @State var selectedDate: Date
    @Binding var presented: Bool
    @Binding var time: TimeObject
    
    init(presented: Binding<Bool>,
         timeObj: Binding<TimeObject>) {
        _presented = presented
        _selectedDate = State(initialValue: DateHelper.getDate(hour: timeObj.wrappedValue.hour,
                                                               minute: timeObj.wrappedValue.minute))
        _time = timeObj
    }

    var body: some View {
        VStack (alignment: .center) {
            ModalHeaderView(title: LocalizedString.Input.reminder) {
                presented = false
            }
            .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
            
            DatePicker("", selection: $selectedDate, displayedComponents: [.hourAndMinute])
                .labelsHidden()
                .datePickerStyle(.wheel)
                .environment(\.calendar, DateHelper.getCurrentCalendar())
                .environment(\.locale, Locale.init(identifier: "fa"))
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            Button {
                presented = false
                let date = DateInRegion(selectedDate, region: .current)
                time.hour = date.hour
                time.minute = date.minute
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

struct ReminerSheet_Previews: PreviewProvider {
    static var previews: some View {
        ReminerSheet(presented: .constant(true),
                     timeObj: .constant(TimeObject(id: "asfaf", hour: 4, minute: 05)))
    }
}
