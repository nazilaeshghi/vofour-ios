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
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            
            HStack {
                if let text = text {
                    Text(text)
                        .applyStyle(style: .number)
                } else {
                    Text(placeholder)
                        .applyStyle(style: .searchbarPlaceholderStyle)
                }
                Spacer()
                Image.arrow
            }
            .padding(.leading, 13)
        }
        .frame(height: PublicTheme.oneLineTextfieldHeight)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(Color.borderColor, lineWidth: 1)
        )
    }
}
