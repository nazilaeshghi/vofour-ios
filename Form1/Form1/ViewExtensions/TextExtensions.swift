//
//  TextExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension Text {
    func applyStyle(style: LabelStyle) -> some View {
        self
            .scaledFont(family: style.fontFamilty, style: style.font)
            .foregroundColor(style.textColor)
    }
}
