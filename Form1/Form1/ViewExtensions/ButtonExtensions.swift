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
    func applyStyle(style: ButtonStyle) -> some View {
        self
            .padding(style.edgeInsets)
            .foregroundColor(style.labelStyle.textColor)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRaduis)
    }
    
    func applyNoPaddingStyle(style: ButtonStyle) -> some View {
        self
            .foregroundColor(style.labelStyle.textColor)
            .background(style.backgroundColor)
    }
    
    func applyNoPaddingWithBorderStyle(style: ButtonStyle) -> some View {
        self
            .foregroundColor(style.labelStyle.textColor)
            .background(style.backgroundColor)
    }
}
