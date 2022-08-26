//
//  LabelDisplayModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct LabelDisplayModel {
    var plainText: String
    var labelStyle: LabelStyle
    
    init(plainText: String,
         style: LabelStyle = .mediumTitle) {
        self.plainText = plainText
        self.labelStyle = style
    }
}
