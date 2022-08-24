//
//  TaskCreationHeader.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-23.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationHeader: View {
    let title: String
    let items: [String]
    @Binding var selectedType: Int
    
    var body: some View {
        VStack (spacing: PublicTheme.vHeaderSpace) {
            TaskStepsHeader(title: title)
            SegmentedPicker(items: items, selection: $selectedType)
        }
    }
}
