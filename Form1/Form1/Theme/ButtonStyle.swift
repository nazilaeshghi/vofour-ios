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
    let edgeInsets: EdgeInsets
    
    static var multiplePrimary: ButtonStyle {
        return .init(labelStyle: .lightRegularMediumTitle,
                     backgroundColor: .primaryColor,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis,
                     edgeInsets: EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
    
    static var multipleDeselectedPrimary: ButtonStyle {
        return .init(labelStyle: .regularMediumTitle,
                     backgroundColor: .white,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis,
                     edgeInsets: EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
    
    static var multipleSecondary: ButtonStyle {
        return .init(labelStyle: .primaryRegularMediumTitle,
                     backgroundColor: .clear,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis,
                     edgeInsets: EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
    }
    
    static var regularSelected: ButtonStyle {
        return .init(labelStyle: .brightRegularSubtitle,
                     backgroundColor: .primaryColor,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis,
                     edgeInsets: EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
    }
    
    static var regularUnSelected: ButtonStyle {
        return .init(labelStyle: .brightRegularSubtitle,
                     backgroundColor: .segmentBG,
                     cornerRaduis: PublicTheme.multiButtonCornerRaduis,
                     edgeInsets: EdgeInsets(top: 8, leading: 14, bottom: 8, trailing: 14))
    }
}
