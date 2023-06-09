//
//  TaskCreationStep1View.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI
import GameController

struct TaskCreationStep1View: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState private var isTextFieldFocused: Bool
    
    @StateObject var viewModel: TaskCreationStep1ViewModel
    
    let isKeyboardConnected = GCKeyboard.coalesced != nil
    
    @State private var showingNextPage: Bool = false
    @State private var showingGoalSheet: Bool = false
    @State private var showingContextSheet: Bool = false
    @State private var shouldShowFooter: Bool = true
    @State private var titleError: InputError? = nil
        
    private let segmentItems = [
        LocalizedString.TaskCreationStep1.createHabitSegmentTitle,
        LocalizedString.TaskCreationStep1.quitHabitSegmentTitle
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: .zero) {
                NavigationLink(isActive: $showingNextPage) {
                    AppCoordinator.shared.makeTaskCreationStep2View(editMode: viewModel.editMode)
                } label: {
                    EmptyView()
                }.opacity(0)
                
                DeviderView()
                
                ScrollView {
                    Group {
                        
                        if !viewModel.editMode {
                            VerticalSpaceView(space: .header)

                            TaskCreationHeader(title: LocalizedString.TaskCreationStep1.header,
                                               items: segmentItems,
                                               selectedType: $viewModel.selectedType)
                        }
                        
                        VerticalSpaceView(space: .inlineForm)
                        
                        VStack(spacing: PublicTheme.vSpace) {
                            if viewModel.editMode {
                                SelectorInputCell(text: viewModel.selectedContextTitle,
                                                 placeholder: LocalizedString.Input.enterHerePlaceholder,
                                                 title: LocalizedString.Input.contextTitle)
                                .onTapGesture {
                                    showingContextSheet = true
                                }
                            }
                            
                            OneLineInputCell(inputText: $viewModel.titleInputText,
                                             placeholder: LocalizedString.Input.enterHerePlaceholder,
                                             title: LocalizedString.Input.enterHereTitle,
                                             error: $titleError)
                            .onChange(of: viewModel.titleInputText) { newValue in
                                titleError = nil
                            }
                            
                            SelectorInputCell(text: viewModel.selectedGoalTitle,
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
                .scrollDismissesKeyboard(.interactively)
                .applyBackgroundColor()
                .focused($isTextFieldFocused)
                
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                               secondaryButtonText: LocalizedString.Buttons.previousTitle,
                               primaryAction: primaryAction,
                               secondaryAction: dismissAction,
                               destructive: false)
                .applyBasicViewStyle()
                .isVisible(shouldShowFooter)
            }
            .background(Color.background)
            .applyToolbarWithBackStyle(with: viewModel.header(),
                                       hideBakcButton: viewModel.editMode,
                                       backAction: dismiss,
                                       closeAction: closeAction)
            .onReceive(NotificationCenter.default.publisher(for: .cloceClick))
            { _ in
                presentationMode.wrappedValue.dismiss()
                viewModel.reset()
            }
            .sheet(isPresented: $showingGoalSheet, onDismiss: refreshGoalTitle, content: makeSelectGoalView)
            .sheet(isPresented: $showingContextSheet, onDismiss: refreshContextTitle, content: makeSelectContextView)
        }
        .onAppear(perform: {
            viewModel.initBinders()
        })
        .navigationBarHidden(true)
    }
    
    func refreshGoalTitle() {
        showingGoalSheet = false
        viewModel.refreshGoalTitle()
    }
    
    func refreshContextTitle() {
        showingContextSheet = false
        viewModel.refreshContextTitle()
    }
    
    func makeSelectGoalView() -> some View {
        return AppCoordinator.shared.makeSelectGoalSheetView()
    }
    
    func makeSelectContextView() -> some View {
        return AppCoordinator.shared.makeSelectContextSheetView()
    }
    
    func closeAction() {
        NotificationCenter.default.post(name: .cloceClick,
                                        object: nil,
                                        userInfo: nil)
        viewModel.reset()
    }
    
    func primaryAction() {
        isTextFieldFocused = false
        if viewModel.checkTitleError() {
            titleError = .activityTitle
            return
        }
        showingNextPage = true
    }
    
    func dismissAction() {
        dismiss()
    }
}

struct TaskCreationStep1View_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = TaskCreationStep1DataManagableMock()
        let viewModel = TaskCreationStep1ViewModel(dataManager: dataManager, editMode: false)
        TaskCreationStep1View(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
