//
//  ReminderCellView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-13.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ReminderCellView: View {
    @Binding var title: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(title.convertToPersian())
                .applyStyle(style: .number)
            Spacer()
            Button {
                action()
            } label: {
                Image.closeIcon
            }
        }
        .padding(10)
        .background(PublicTheme.segmentBG)
        .cornerRadius(PublicTheme.cornerRaduis)
    }
}

struct ReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderCellView(title: .constant("09:00"), action: {
            
        }).environment(\.layoutDirection, .rightToLeft)
    }
}
