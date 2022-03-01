//
//  LabelDisplayModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct LabelDisplayModel {
    let plainText: String
    let labelStyle: LabelStyle
    
    init(plainText: String,
         style: LabelStyle = .titleStyle) {
        self.plainText = plainText
        self.labelStyle = style
    }
}
