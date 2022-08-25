//
//  ButtonExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

enum ButtonType {
    case singel
    case multiple
}

extension Button {
    func applyStyle(style: CustomButtonStyle) -> some View {
        self
            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRaduis)
            .frame(height: style.height)
    }
    
    func applyNoPaddingStyle(style: CustomButtonStyle) -> some View {
        self
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
    }
    
    func applyNoPaddingWithBorderStyle(style: CustomButtonStyle) -> some View {
        self
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
    }
}
