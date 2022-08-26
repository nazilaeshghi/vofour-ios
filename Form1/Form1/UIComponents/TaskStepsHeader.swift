//
//  TaskStepsHeader.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-13.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskStepsHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .applyStyle(style: .tableHeaderStyle)
            Spacer()
        }
    }
}
