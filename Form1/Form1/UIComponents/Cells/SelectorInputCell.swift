//
//  SelectorInoutCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/30/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectorInputCell: View {
    var text: String?
    var placeholder: String
    var title: String
    @Binding var error: InputError?
    
    init(text: String? = nil,
         placeholder: String,
         title: String,
         error: Binding<InputError?> = .constant(nil)) {
        self.text = text
        self.placeholder = placeholder
        self.title = title
        _error = error
    }
    
    var body: some View {
        VStack(spacing: PublicTheme.formInputPadding) {
            InputCellTitleView(title: title)
            CustomSelector(text: text,
                           placeholder: placeholder,
                           error: $error)
            if error != nil {
                InputErrorView(title: error?.localizedValue ?? "")
            }
        }
    }
}

struct SelectorInoutCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectorInputCell(placeholder: LocalizedString.Input.enterHerePlaceholder,
                          title: LocalizedString.Input.enterHereTitle)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
