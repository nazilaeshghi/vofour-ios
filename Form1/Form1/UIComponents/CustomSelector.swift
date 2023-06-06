//
//  CustomSelector.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/30/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomSelector: View {
    var text: String?
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
                if let text = text {
                    Text(text)
                        .applyStyle(style: .regularTitle)
                } else {
                    Text(placeholder)
                        .applyStyle(style: .lightTitlePlaceholder)
                }
                Spacer()
                Image.arrow
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
