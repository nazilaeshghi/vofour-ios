//
//  ButtonStyle.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ButtonStyle {
    let font: FontStyle
    let fontFamilty: FontFamily
    let textColor: Color
    let backgroundColor: Color
    let height: CGFloat
    let cornerRaduis: CGFloat
    
    static var primary: ButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white, backgroundColor: PublicTheme.primaryColor, height: 40, cornerRaduis: PublicTheme.cornerRaduis)
    }
    
    static var multiplePrimary: ButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: .white, backgroundColor: PublicTheme.primaryColor, height: 32, cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
    
    static var multipleSecondary: ButtonStyle {
        return .init(font: .title, fontFamilty: .regular, textColor: PublicTheme.primaryColor, backgroundColor: .white, height: 32, cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
}
