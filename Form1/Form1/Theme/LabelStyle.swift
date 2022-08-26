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
    
    
    static var bigNumberStyle: LabelStyle {
        return .init(font: .bigTitle, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var bigGreenNumberStyle: LabelStyle {
        return .init(font: .bigTitle, fontFamilty: .regular, textColor: .greenColor)
    }
    
    static var verySmallGreenNumberStyle: LabelStyle {
        return .init(font: .verySmall, fontFamilty: .regular, textColor: .greenColor)
    }
    
    static var titleStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var subtitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .secondaryTextColor)
    }
    
    static var number: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var smallTitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var tableHeaderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .medium, textColor: .primaryColor)
    }
    
    static var secondaryTableHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var sectionHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var homeHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .homeHeaderColor)
    }
    
    static var mediumHeaderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var lightHeaderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .light, textColor: .primaryTextColor)
    }
    
    static var searchbarPlaceholderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .light, textColor: .placeholderTextColor)
    }
    
    static var buttonTitleStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .white)
    }
    
    static var deselectedButtonTitleStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var buttonTitleStyleSecondary: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var operandStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var tabbarStyle: LabelStyle {
        return .init(font: .verySmall, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var verySmallHeaderStyle: LabelStyle {
        return .init(font: .verySmall, fontFamilty: .regular, textColor: .headerSecondaryTextColor)
    }
    
    static var verySmallCollectionStyle: LabelStyle {
        return .init(font: .verySmall, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var homeEmptyStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .emptyTextColor)
    }
    
    static var hugeTitleStyle: LabelStyle {
        return .init(font: .hugeTitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
}
