//
//  CustomSelector.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/30/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomSelector: View {
    @State var text: String
    var placeholder: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            
            HStack {
                if text.isEmpty {
                    Text(placeholder)
                        .applyStyle(style: .searchbarPlaceholderStyle)
                } else{
                    Text(text)
                        .applyStyle(style: .number)
                }
                Spacer()
                Image("Arrow")
            }
            .padding(.leading, 13)
        }
        .frame(height: PublicTheme.oneLineTextfieldHeight)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inoutTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}
