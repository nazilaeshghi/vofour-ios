//
//  ReminderCellView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-13.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI
import SwiftDate

struct ReminderCellView: View {
    @Binding var time: TimeObject
    let formatter = DateComponentsFormatter()
    
    let action: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(time.representingString.convertToPersian())
                    .applyStyle(style: .number)
                Spacer()
                
                Button {
                    action()
                } label: {
                    Image.closeIcon
                }
            }
            .padding(10)
            .background(Color.segmentBG)
            .cornerRadius(PublicTheme.cornerRaduis)
        }
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(time: .constant(TimeObject(id: "asfaf", hour: 4, minute: 05)), action: {})
        .environment(\.layoutDirection, .rightToLeft)
    }
}
