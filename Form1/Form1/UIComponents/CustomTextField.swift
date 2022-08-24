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
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            HStack {
                TextField("", text: $text)
                    .scaledFont(family: .light, style: .title2)
                    .placeholder(when: text.isEmpty) {
                        Text(placeholder)
                            .applyStyle(style: .searchbarPlaceholderStyle)
                    }
            }
            .padding(.leading, 13)
        }
        .frame(height: PublicTheme.oneLineTextfieldHeight)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}
