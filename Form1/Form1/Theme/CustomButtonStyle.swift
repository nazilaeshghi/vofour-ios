//
//  ButtonStyle.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CustomButtonStyle {
    let font: FontStyle
    let fontFamilty: FontFamily
    let textColor: Color
    let backgroundColor: Color
    let height: CGFloat
    let cornerRaduis: CGFloat
    
    static var primary: CustomButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white, backgroundColor: PublicTheme.primaryColor, height: 40, cornerRaduis: PublicTheme.cornerRaduis)
    }
    
    static var multiplePrimary: CustomButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white, backgroundColor: PublicTheme.primaryColor, height: 32, cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
    
    static var multipleDeselectedPrimary: CustomButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .black, backgroundColor: .white, height: 32, cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
    
    static var multipleSecondary: CustomButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: PublicTheme.primaryColor, backgroundColor: .clear, height: 32, cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
}
