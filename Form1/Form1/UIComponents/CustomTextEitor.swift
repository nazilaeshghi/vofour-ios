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
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(Color.borderColor, lineWidth: 1)
        )
    }
}

struct CustomMultiLineTextEditor_Previews: PreviewProvider {
    @State static var inputText: String = ""
    
    static var previews: some View {
        CustomMultiLineTextEditor(text: $inputText, placeholder: LocalizedString.Input.enterHerePlaceholder)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

struct CustomTextEditor: View {
    let placeholder: String
    @Binding var text: String
    let internalPadding: CGFloat = 5
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty  {
                HStack {
                    VStack {
                        Text(placeholder)
                            .applyStyle(style: .lightTitlePlaceholder)
                            .foregroundColor(Color.primaryColor.opacity(0.25))
                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                    }
                    Spacer()
                }
                
            }
            
            TextEditor(text: $text)
                .padding(internalPadding)
                .scrollContentBackground(.hidden)
            
        }.onAppear() {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear() {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

