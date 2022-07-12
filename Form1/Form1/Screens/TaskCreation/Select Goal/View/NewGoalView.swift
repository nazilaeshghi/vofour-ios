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
    
    @Binding var goalName: String?
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Spacer()
            
            ModalHeaderView(title: LocalizedString.SelectGoalPage.newGoal) {
                goalName = nil
                isPresented = false
            }
            
            VStack {
                OneLineInputCell(inputText: $titleInputText.onChange(titleChanged),
                                 placeholder: LocalizedString.Input.enterHerePlaceholder,
                                 title: "")
                Spacer()
                PrimarySubmitButton(title: LocalizedString.SelectGoalPage.submitNewGoal, action: {
                    isPresented = false
                })
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    func titleChanged(to value: String) {
        guard !value.isBlank else { return }
        goalName = value
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(goalName: .constant(""), isPresented: .constant(false))
            .environment(\.layoutDirection, .rightToLeft)
    }
}
