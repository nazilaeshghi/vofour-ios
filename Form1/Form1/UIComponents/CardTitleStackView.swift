//
//  CardTitleStackView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CardTitleStackView: View {
    var title: LabelDisplayModel
    var subtitle: LabelDisplayModel
    
    var body: some View {
        VStack {
            HStack {
                Text(title.plainText)
                    .applyStyle(style: title.labelStyle)
                Spacer()
            }
            
            HStack {
                Text(subtitle.plainText)
                    .applyStyle(style: subtitle.labelStyle)
                Spacer()
            }
        }
    }
}
