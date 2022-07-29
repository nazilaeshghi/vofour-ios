//
//  LabelStyle.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct LabelStyle {
    let font: FontStyle
    let fontFamilty: FontFamily
    let textColor: Color
    
    static var titleStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: PublicTheme.sectionHeaderColor)
    }
    
    static var subtitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .white)
    }
    
    static var number: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .black)
    }
    
    static var smallTitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .black)
    }
    
    static var tableHeaderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .medium, textColor: PublicTheme.primaryColor)
    }
    
    static var sectionHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: PublicTheme.sectionHeaderColor)
    }
    
    static var searchbarPlaceholderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .light, textColor: PublicTheme.placeholderTextColor)
    }
    
    static var buttonTitleStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .white)
    }
    
    static var deselectedButtonTitleStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .black)
    }
    
    static var buttonTitleStyleSecondary: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: PublicTheme.primaryColor)
    }
    
    static var operandStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: PublicTheme.primaryColor)
    }
    
    static var tabbarStyle: LabelStyle {
        return .init(font: .verySmall, fontFamilty: .regular, textColor: PublicTheme.primaryColor)
    }
}
