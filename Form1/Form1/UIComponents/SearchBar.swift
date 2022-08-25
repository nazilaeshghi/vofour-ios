//
//  SearchBar.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .background(.white)
            HStack {
                Image.search
                TextField(LocalizedString.ContextPage.searchPlaceHolder, text: $searchText)
                    .scaledFont(family: .light, style: .title2)
            }
            .cornerRadius(PublicTheme.inputTextCornerRadius)
            .padding(.leading, 13)
        }
        .frame(height: 40)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}
