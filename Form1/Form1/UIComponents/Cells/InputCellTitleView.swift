//
//  InputCellTitleView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI


struct InputCellTitleView: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .applyStyle(style: .sectionHeaderStyle)
            Spacer()
        }
    }
}
