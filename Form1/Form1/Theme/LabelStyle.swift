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
    static var regularGiantTitleStyle: LabelStyle {
        return .init(font: .giantTitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    // Larg title
    static var primaryRegularLargTitle: LabelStyle {
        return .init(font: .largeTitle, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var greenRegularLargTitle: LabelStyle {
        return .init(font: .largeTitle, fontFamilty: .regular, textColor: .greenColor)
    }
    

    // Medium
    static var primaryRegularMediumTitle: LabelStyle {
        return .init(font: .mediumTitle, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var regularMediumTitle: LabelStyle {
        return .init(font: .mediumTitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var lightRegularMediumTitle: LabelStyle {
        return .init(font: .mediumTitle, fontFamilty: .regular, textColor: .white)
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
    
    static var brightRegularTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white)
    }
    
    static var primaryTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var destructiveTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .destructiveColor)
    }
    
    static var emptyRegularTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .emptyTextColor)
    }
    
    static var primaryMediumTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .medium, textColor: .primaryColor)
    }
    
    static var mediumTitle: LabelStyle {
        return .init(font: .title, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    // Subtitle
    static var regularSubtitle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var mediumSubtitle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .primaryTextColor)
    }
    
    static var secondaryRegularSubtitle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .secondaryTextColor)
    }
    
    static var headerMediumSubtitle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .homeHeaderColor)
    }
    
    // Body
    static var regularBody: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .primaryTextColor)
    }
    
    static var primaryRegularBody: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .primaryColor)
    }
    
    static var greenRegularBody: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .greenColor)
    }
    
    static var secondaryRegularBody: LabelStyle {
        return .init(font: .body, fontFamilty: .regular, textColor: .headerSecondaryTextColor)
    }
}
