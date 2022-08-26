//
//  PrimarySubmitButton.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-25.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct PrimarySubmitButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: .zero) {
            Button {
                action()
            } label: {
                Spacer()
                Text(title)
                    .applyStyle(style: .brightRegularTitle)
                Spacer()
            }
            .applyStyle(style: .multiplePrimary)
        }
        .frame(height: PublicTheme.buttonHeight)
    }
}

