//
//  TaskCreationStep2View.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationStep2View: View {
    @State private var selectedType = 0
    @State private var reminderSelected = 0
    
    private let segmentItems = [
        LocalizedString.TaskCreationStep2.repeatitiveActivity,
        LocalizedString.TaskCreationStep2.nonRepeatitiveActivity
    ]
    
    private let reminderSegmentItems = [
        LocalizedString.TaskCreationStep2.needReminder,
        LocalizedString.TaskCreationStep2.dontNeedReminder
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack (spacing: 24) {
                    HStack {
                        Text(LocalizedString.TaskCreationStep1.header)
                            .applyStyle(style: LabelStyle.tableHeaderStyle)
                        Spacer()
                    }
                    
                    SegmentedPicker(items: segmentItems, selection: $selectedType)
                    
                    SelectorInoutCell(placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                                      title: LocalizedString.Input.dateSelectoreTitle)
                    SelectorInoutCell(placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                                      title: LocalizedString.Input.periodSelectorTitle)
                    
                    RepeatView()
                    SegmentedPicker(items: reminderSegmentItems, selection: $reminderSelected)

                    Spacer()
                }
                .padding()
            }
            Spacer()
            HStack {
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                              secondaryButtonText: LocalizedString.Buttons.previousTitle)
                    .frame(height: 60)
            }
        }
    }
}

struct TaskCreationStep2View_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationStep2View()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
