//
//  TaskCreationStep1View.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationStep1View: View {
    @StateObject var viewModel: TaskCreationStep1ViewModel
    @State private var selectedType = 0
    
    private let segmentItems = [
        LocalizedString.TaskCreationStep1.createHabitSegmentTitle,
        LocalizedString.TaskCreationStep1.quitHabitSegmentTitle
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                ScrollView {
                    VStack (spacing: 24) {
                        HStack {
                            Text(LocalizedString.ContextPage.subHeader)
                                .applyStyle(style: LabelStyle.tableHeaderStyle)
                            Spacer()
                        }
                        
                        SegmentedPicker(items: segmentItems, selection: $selectedType)
                        OneLineInputCell(placeholder: LocalizedString.Input.enterHerePlaceholder,
                                         title: LocalizedString.Input.enterHereTitle)
                        SelectorInoutCell(placeholder: LocalizedString.Input.goalSelectorTitle,
                                          title: LocalizedString.Input.goalSelectorPlaceholder)
                        MultipleLineInputCell(placeholder: LocalizedString.Input.obstaclePlaceholder,
                                              title: LocalizedString.Input.obstacleHeader)
                        MultipleLineInputCell(placeholder: LocalizedString.Input.reasonPlaceholder,
                                              title: LocalizedString.Input.reasonTitle)
                        MultipleLineInputCell(placeholder: LocalizedString.Input.enterHerePlaceholder,
                                              title: LocalizedString.Input.for100Title)
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
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarStyle(with: viewModel.header())
        }
        .navigationBarHidden(true)
    }
}

struct TaskCreationStep1View_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = TaskCreationStep1DataManagableMock()
        let viewModel = TaskCreationStep1ViewModel(dataManager: dataManager)
        TaskCreationStep1View(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
