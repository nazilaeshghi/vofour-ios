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
                TextView(model: title)
                Spacer()
            }
            
            HStack {
                TextView(model: subtitle)
                Spacer()
            }
        }
    }
}
