//
//  InputCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct OneLineInputCell: View {
    @Binding var inputText: String
    var placeholder: String
    var title: String
    @Binding var error: InputError?
    
    var body: some View {
        VStack(spacing: PublicTheme.inputCellSpacing) {
            InputCellTitleView(title: title)
            CustomTextField(text: $inputText,
                            placeholder: placeholder,
                            error: $error)
            if error != nil {
                InputErrorView(title: error?.localizedValue ?? "")
            }
        }
    }
}

struct InputCell_Previews: PreviewProvider {
    @State static var inputText: String = ""

    static var previews: some View {
        OneLineInputCell(inputText: $inputText,
                         placeholder: LocalizedString.Input.enterHerePlaceholder,
                         title: LocalizedString.Input.enterHereTitle,
                         error: .constant(.activityTitle))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
