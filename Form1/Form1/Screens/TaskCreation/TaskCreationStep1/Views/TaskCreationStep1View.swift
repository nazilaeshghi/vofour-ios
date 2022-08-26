//
//  TaskCreationStep1View.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationStep1View: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState private var isTextFieldFocused: Bool
    
    @StateObject var viewModel: TaskCreationStep1ViewModel
    
    @State private var showingNextPage: Bool = false
    @State private var showingGoalSheet = false
    
    let isFirstPage: Bool
    
    private let segmentItems = [
        LocalizedString.TaskCreationStep1.createHabitSegmentTitle,
        LocalizedString.TaskCreationStep1.quitHabitSegmentTitle
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: .zero) {
                NavigationLink(isActive: $showingNextPage) {
                    AppCoordinator.shared.makeTaskCreationStep2View()
                } label: {
                    EmptyView()
                }.opacity(0)
                
                DeviderView()
                
                ScrollView {
                    Group {
                        VerticalSpaceView(space: .header)
                        
                        TaskCreationHeader(title: LocalizedString.TaskCreationStep1.header,
                                           items: segmentItems,
                                           selectedType: $viewModel.selectedType)
                        
                        VerticalSpaceView(space: .inlineForm)
                        
                        VStack(spacing: PublicTheme.vSpace) {
                            OneLineInputCell(inputText: $viewModel.titleInputText,
                                             placeholder: LocalizedString.Input.enterHerePlaceholder,
                                             title: LocalizedString.Input.enterHereTitle)
                            
                            SelectorInoutCell(text: viewModel.selectedGoalTitle,
                                              placeholder: LocalizedString.Input.goalSelectorTitle,
                                              title: LocalizedString.Input.goalSelectorPlaceholder)
                                .onTapGesture {
                                    showingGoalSheet = true
                                }
                            
                            MultipleLineInputCell(inputText: $viewModel.preventionInputText,
                                                  placeholder: LocalizedString.Input.obstaclePlaceholder,
                                                  title: LocalizedString.Input.obstacleHeader)
                            
                            MultipleLineInputCell(inputText: $viewModel.reasonInputText,
                                                  placeholder: LocalizedString.Input.reasonPlaceholder,
                                                  title: LocalizedString.Input.reasonTitle)
                            
                            MultipleLineInputCell(inputText: $viewModel.for100InputText,
                                                  placeholder: LocalizedString.Input.enterHerePlaceholder,
                                                  title: LocalizedString.Input.for100Title)
                            
                        }
                        
                        VerticalSpaceView(space: .header)
                    }
                    .applyBasicViewStyle()
                }
                .applyBackgroundColor()
                .focused($isTextFieldFocused)
                
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                               secondaryButtonText: LocalizedString.Buttons.previousTitle,
                               dismiss: dismiss,
                               primaryAction: { showingNextPage = true })
                    .frame(height: isTextFieldFocused ? 0 : PublicTheme.buttonHeight + (PublicTheme.buttonSpacing * 2))
                    .applyBasicViewStyle()
            }
            .applyToolbarWithBackStyle(with: viewModel.header(),
                                       hideBakcButton: isFirstPage,
                                       backAction: dismiss,
                                       closeAction: {
                NotificationCenter.default.post(name: .cloceClick,
                                                object: nil,
                                                userInfo: nil)
            })
            .background(.background)
            .onReceive(NotificationCenter.default.publisher(for: .cloceClick))
            { obj in
                presentationMode.wrappedValue.dismiss()
            }
            .sheet(isPresented: $showingGoalSheet) {
                viewModel.refreshGoalTitle()
            } content: {
                AppCoordinator.shared.makeSelectGoalSheetView()
            }
        }
        .onAppear(perform: {
            viewModel.initBinders()
        })
        .navigationBarHidden(true)
    }
}

struct TaskCreationStep1View_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = TaskCreationStep1DataManagableMock()
        let viewModel = TaskCreationStep1ViewModel(dataManager: dataManager)
        TaskCreationStep1View(viewModel: viewModel, isFirstPage: false)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
