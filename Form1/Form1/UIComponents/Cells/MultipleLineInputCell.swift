//
//  MultipleLineInputCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/27/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct MultipleLineInputCell: View {
    @State var searchText = ""
    var placeholder: String
    var title: String
    
    var body: some View {
        VStack(spacing: PublicTheme.formInputPadding) {
            HStack {
                Text(title)
                    .applyStyle(style: .sectionHeaderStyle)
                Spacer()
            }
            CustomMultiLineTextEditor(text: $searchText,
                                      placeholder: placeholder)
        }
    }
}

struct MultipleLineInputCell_Previews: PreviewProvider {
    static var previews: some View {
        MultipleLineInputCell(placeholder: LocalizedString.Input.enterHerePlaceholder,
                              title: LocalizedString.Input.enterHereTitle)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
