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
    
    // Giant
    static var hugeTitleStyle: LabelStyle {
        return .init(font: .giantTitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    // Larg title
    static var primaryLargTitle: LabelStyle {
        return .init(font: .largeTitle, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var largTitleWithGreenColor: LabelStyle {
        return .init(font: .largeTitle, fontFamilty: .regular, textColor: .greenColor)
    }
    

    // Medium
    static var primaryMediumTitle: LabelStyle {
        return .init(font: .mediumTitle, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var mediumTitle: LabelStyle {
        return .init(font: .mediumTitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    // Title
    static var lightTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .light, textColor: .primaryTextColor)
    }
    
    static var lightTitlePlaceholder: LabelStyle {
        return .init(font: .title, fontFamilty: .light, textColor: .placeholderTextColor)
    }
    
    static var regularTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var brightButtonTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white)
    }
    
    static var deselectedButtonTitleStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var buttonTitleStyleSecondary: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var homeEmptyStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .emptyTextColor)
    }
    
    static var tableHeaderStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .medium, textColor: .primaryColor)
    }
    
    static var mediumHeaderStyle: LabelStyle {
        return .init(font: .title, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    // Subtitle
    static var smallTitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var sectionHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var subtitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .secondaryTextColor)
    }
    
    static var secondaryTableHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var homeHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .homeHeaderColor)
    }
    
    // Body
    static var verySmallGreenNumberStyle: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .greenColor)
    }
    
    static var tabbarStyle: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var verySmallHeaderStyle: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .headerSecondaryTextColor)
    }
    
    static var verySmallCollectionStyle: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .primaryTextColor)
    }
}
