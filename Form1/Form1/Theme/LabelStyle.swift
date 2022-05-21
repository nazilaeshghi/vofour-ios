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
    
    static var smallTitleStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .regular, textColor: .black)
    }
    
    static var tableHeaderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .medium, textColor: PublicTheme.primaryColor)
    }
    
    static var sectionHeaderStyle: LabelStyle {
        return .init(font: .subtitle, fontFamilty: .medium, textColor: .black)
    }
    
    static var searchbarPlaceholderStyle: LabelStyle {
        return .init(font: .title2, fontFamilty: .light, textColor: .gray)
    }
}


struct LocalizedString {
    
    enum ContextPage {
        static let header = "ایجاد فعالیت"
        static let subHeader = "یکی از زمینه‌های زیر را انتخاب کنید."
        static let searchHeader = "زمینه‌ها"
        static let searchPlaceHolder = "جستجو"
    }
    
    enum SelectgoalPage {
        static let sectionHeader = "اهداف تعریف شده"
        static let pageHeader = "انتخاب هدف"
    }
}
