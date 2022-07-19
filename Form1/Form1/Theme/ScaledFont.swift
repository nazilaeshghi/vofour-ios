//
//  ScaledFont.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/13/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
    @Environment(\.sizeCategory) var sizeCategory
    var name: String
    var size: CGFloat

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name, size: scaledSize))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    
    func scaledFont(family: FontFamily = .regular, style: FontStyle = .title2) -> some View {
        return self.modifier(ScaledFont(name: family.rawValue, size: style.rawValue))
    }
    
    func scaledFont(name: String, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}

enum FontFamily: String {
    case light = "Vazir-Light"
    case medium = "Vazir-Medium"
    case regular = "Vazir-Regular"
}

enum FontStyle: CGFloat {
    case title = 20
    case title2 = 17
    case subtitle = 14
    case verySmall = 12
}
