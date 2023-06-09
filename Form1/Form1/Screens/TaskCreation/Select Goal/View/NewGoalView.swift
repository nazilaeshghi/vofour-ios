//
//  NewGoalView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-12.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct NewGoalView: View {
    @State private var titleInputText = ""
    @Binding var isPresented: Bool
    @State private(set) var error: InputError?
    @StateObject var viewModel: NewGoalViewModel
    @FocusState private var keyboardFocused: Bool

    var body: some View {
        VStack {
            Spacer()
            
            ModalHeaderView(title: LocalizedString.SelectGoalPage.newGoal) {
                isPresented = false
            }
            
            Group {
                VStack {
                    OneLineInputCell(inputText: $titleInputText.onChange(titleChanged),
                                     placeholder: LocalizedString.Input.enterHerePlaceholder,
                                     title: "",
                                     error: $error)
                    .focused($keyboardFocused)
                    .onChange(of: titleInputText) { newValue in
                        error = nil
                    }
                    
                    Spacer()
                    PrimarySubmitButton(title: LocalizedString.SelectGoalPage.submitNewGoal, action: {
                        if viewModel.createGoal(title: titleInputText) {
                            isPresented = false
                        } else {
                            error = .duplicateGoal
                        }
                        
                    })
                }
            }
            .applyBasicViewStyle()
        }
        .onAppear {
            keyboardFocused = true
        }
        .applyBackgroundColor()
        .environment(\.layoutDirection, .rightToLeft)
        .navigationViewStyle(.stack)

    }
    
    func titleChanged(to value: String) {
        guard !value.isBlank else { return }
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(isPresented: .constant(false),
                    viewModel: NewGoalViewModel(dataManger: CreateGoalDataManagerMock()))
            .environment(\.layoutDirection, .rightToLeft)
    }
}
