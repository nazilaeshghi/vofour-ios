//
//  MultipleLineInputCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/27/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct MultipleLineInputCell: View {
    @Binding var inputText: String
    var placeholder: String
    var title: String
    
    var body: some View {
        VStack(spacing: PublicTheme.formInputPadding) {
            InputCellTitleView(title: title)
            CustomMultiLineTextEditor(text: $inputText,
                                      placeholder: placeholder)
        }
    }
}

struct MultipleLineInputCell_Previews: PreviewProvider {
    @State static var inputText: String = ""
    
    static var previews: some View {
        MultipleLineInputCell(inputText: $inputText,
                              placeholder: LocalizedString.Input.enterHerePlaceholder,
                              title: LocalizedString.Input.enterHereTitle)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
