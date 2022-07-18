//
//  QuitHabitSteps2.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-05.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct QuitHabitSteps2: View {
    @State private var selectedType = 0
    
    private let segmentItems = [
        LocalizedString.QuitHabitStep2.quitEntirely,
        LocalizedString.QuitHabitStep2.withLimit
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(LocalizedString.TaskCreationStep1.header)
                            .applyStyle(style: LabelStyle.tableHeaderStyle)
                        Spacer()
                    }
                    SegmentedPicker(items: segmentItems, selection: $selectedType)
                    SelectorInoutCell(placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                                      title: LocalizedString.Input.dateSelectoreTitle)
                }
            }
            Spacer()
            HStack {
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                               secondaryButtonText: LocalizedString.Buttons.previousTitle, primaryAction: {}, secondaryAction: {})
                    .frame(height: 60)
            }
        }
        .padding()
    }
}

struct QuitHabitSteps2_Previews: PreviewProvider {
    static var previews: some View {
        QuitHabitSteps2()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
