//
//  CustomTextEitor.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/27/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomMultiLineTextEditor: View {
    @Binding var text: String
    var placeholder: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            HStack {
                CustomTextEditor(placeholder: placeholder, text: $text)
            }
            .padding(.leading, 13)
        }
        .frame(height: PublicTheme.multipleLineTextfieldHeight)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inoutTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 5
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty  {
                Text(placeholder)
                    .applyStyle(style: .searchbarPlaceholderStyle)
                    .foregroundColor(Color.primary.opacity(0.25))
                    .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                
            }
            TextEditor(text: $text)
                .padding(internalPadding)
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

