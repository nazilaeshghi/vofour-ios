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
    
    @State private var showingSheet = false
    
    @StateObject var viewModel: TaskCreationStep1ViewModel
    @State private var selectedType = 0
    
    @State private var titleInputText = ""
    @State private var preventionInputText = ""
    @State private var reasonInputText = ""
    @State private var for100InputText = ""
    @State private var goalID: String? = nil
    @State var nextPagelinkIsActive: Bool = false
    
    let isFirstPage: Bool
    
    private let segmentItems = [
        LocalizedString.TaskCreationStep1.createHabitSegmentTitle,
        LocalizedString.TaskCreationStep1.quitHabitSegmentTitle
    ]
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 0) {
                NavigationLink(isActive: $nextPagelinkIsActive) {
                    AppCoordinator.shared.makeTaskCreationStep2View()
                } label: {
                    EmptyView()
                }.opacity(0)
                
                DeviderView()

                ScrollView {
                    VStack (spacing: 24) {
                        
                        TaskStepsHeader(title: LocalizedString.TaskCreationStep1.header)
                        
                        SegmentedPicker(items: segmentItems, selection: $selectedType)
                            .onChange(of: selectedType) { newValue in
                                viewModel.update(segemntSelection: newValue)
                            }
                    }
                    
                    Spacer()
                        .frame(height: 32)
                    
                    VStack(spacing: 32) {
                        OneLineInputCell(inputText: $titleInputText.onChange(titleChanged),
                                         placeholder: LocalizedString.Input.enterHerePlaceholder,
                                         title: LocalizedString.Input.enterHereTitle)
                        
                        SelectorInoutCell(text: viewModel.selectedGoalTitle,
                                          placeholder: LocalizedString.Input.goalSelectorTitle,
                                          title: LocalizedString.Input.goalSelectorPlaceholder)
                            .onTapGesture {
                                showingSheet = true
                            }
                        
                        MultipleLineInputCell(inputText: $preventionInputText.onChange(preventionChanged),
                                              placeholder: LocalizedString.Input.obstaclePlaceholder,
                                              title: LocalizedString.Input.obstacleHeader)
                        
                        MultipleLineInputCell(inputText: $reasonInputText.onChange(reasonChanged),
                                              placeholder: LocalizedString.Input.reasonPlaceholder,
                                              title: LocalizedString.Input.reasonTitle)
                        
                        MultipleLineInputCell(inputText: $for100InputText.onChange(for100Changed),
                                              placeholder: LocalizedString.Input.enterHerePlaceholder,
                                              title: LocalizedString.Input.for100Title)
                        
                    }
                }
                .applyBasicViewStyle()
                .safeAreaInset(edge: .top, spacing: 0) {
                    Spacer().frame(height: 24)
                }
                .focused($isTextFieldFocused)
                
                Spacer()
                    .frame(height: 32)
                
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                               secondaryButtonText: LocalizedString.Buttons.previousTitle,
                               primaryAction: {
                    nextPagelinkIsActive = true
                }, secondaryAction: {
                    dismiss()
                })
                    .applyBasicViewStyle()
                    .frame(height: isTextFieldFocused ? 0 : 60)
                

            }
            .applyToolbarWithBackStyle(with: viewModel.header(),
                                       hideBakcButton: isFirstPage,
                                       backAction: dismiss,
                                       closeAction: {
                NotificationCenter.default.post(name: .cloceClick,
                                                object: nil,
                                                userInfo: nil)
            })
            .background(PublicTheme.background)
            .onReceive(NotificationCenter.default.publisher(for: .cloceClick))
            { obj in
                presentationMode.wrappedValue.dismiss()
            }
            .sheet(isPresented: $showingSheet) {
                    viewModel.refreshGoalTitle()
            } content: {
                AppCoordinator.shared.makeSelectGoalSheetView()
            }

        }
        .navigationBarHidden(true)
    }
    
    
    func titleChanged(to value: String) {
        viewModel.updateActivityTitle(title: value)
    }
    
    func reasonChanged(to value: String) {
        viewModel.updateActivityReason(text: value)
    }
    
    func preventionChanged(to value: String) {
        viewModel.updateActivityPrevention(text: value)
    }
    
    func for100Changed(to value: String) {
        viewModel.updateActivityFor100(text: value)
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
