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
        return .init(font: .title, fontFamilty: .regular, textColor: .black)
    }
    
    static var subtitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .white)
    }
    
    static var number: LabelStyle {
        return .init(font: .title2, fontFamilty: .regular, textColor: .black)
    }
}
