//
//  ButtonStyle.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ButtonStyle {
    let labelStyle: LabelStyle
    let backgroundColor: Color
    let cornerRaduis: CGFloat
    
    static var multiplePrimary: ButtonStyle {
        return .init(labelStyle: .lightRegularMediumTitle,
                     backgroundColor: .primaryColor,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
    
    static var multipleDeselectedPrimary: ButtonStyle {
        return .init(labelStyle: .regularMediumTitle,
                     backgroundColor: .white,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
    
    static var multipleSecondary: ButtonStyle {
        return .init(labelStyle: .primaryRegularMediumTitle,
                     backgroundColor: .clear,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis)
    }
}
