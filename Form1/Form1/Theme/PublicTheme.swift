//
//  PublicTheme.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension Color {
    static var disabledColor: Color { return Color(hex: "BBC7D3") }
    static var contextBackgroundColor: Color { return Color(hex: "EFF3F6") }
    static var background: Color { return Color(hex: "FAFBFC") }
    static var primaryColor: Color { return Color(hex: "1757A6") }
    static var primaryLightColor: Color { return Color(hex: "C2DDFC") }
    static var headerSecondaryTextColor: Color { return Color(hex: "6E7E91") }
    static var borderColor: Color { return Color(hex: "D9E0E9") }
    static var primaryTextColor: Color { return Color(hex: "141D2B") }
    static var homeHeaderColor: Color { return Color(hex: "646b75") }
    static var placeholderTextColor: Color { return Color(hex: "A0AEBD") }
    static var segmentBG: Color { return Color(hex: "EFF2F9") }
    static var greenColor: Color { return Color(hex: "01B7A7") }
    static var emptyTextColor: Color { return Color(hex: "6e7f91") }
    static var secondaryTextColor: Color { return Color(hex: "4B5666") }
}

struct PublicTheme {
    // Corner raduis
    static let cornerRaduis: CGFloat = 16
    static let multiButtonCornerRaduis: CGFloat = 8
    static let inputTextCornerRadius: CGFloat = 8
    
    // Height
    static let oneLineTextfieldHeight: CGFloat = 40
    static let multipleLineTextfieldHeight: CGFloat = 80
    
    // Space
    static let vSpace: CGFloat = 32
    static let vHeaderSpace: CGFloat = 24
    static let inputCellSpacing: CGFloat = 6
    static let collectionSpace: CGFloat = 16
    static let miniCollectionSpace: CGFloat = 12
    static let textsSpacing: CGFloat = 8
    
    // Pading
    static let hPadding: CGFloat = 24
    static let formInputPadding: CGFloat = 4
    static let scrollViewPadding: CGFloat = 24
    static let buttonSpacing: CGFloat = 16
    static let containerPadding: CGFloat = 16

    static let circleSize: CGFloat = 38
    static let buttonHeight: CGFloat = 48
}
