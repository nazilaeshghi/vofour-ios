//
//  CustomTextField.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: String
    @Binding var error: InputError?
    
    var borderColor: Color {
        return error == nil ? Color.borderColor :  Color.errorBorderColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            HStack {
                TextField("", text: $text)
                    .scaledFont(family: .light, style: .title)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .applyStyle(style: .lightTitlePlaceholder)
                    }
            }
            .padding(.leading, 13)
        }
        .frame(height: PublicTheme.oneLineTextfieldHeight)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(borderColor, lineWidth: 1)
        )
    }
}
