//
//  AddReminderCellView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct AddReminderCellView: View {
    var body: some View {
        HStack {
            Text(LocalizedString.TaskCreationStep2.addReminder)
                .applyStyle(style: .tableHeaderStyle)
            Spacer()
            Image.bluePlus
        }
        .padding(0)
    }
}

struct AddReminderCellView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderCellView()
    }
}
