//
//  TwoButtonsView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/30/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TwoButtonsView: View {
    var primaryButtonText: String
    var secondaryButtonText: String

    let dismiss: DismissAction
    let primaryAction: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 16) {
                Button {
                    primaryAction()
                } label: {
                    Spacer()
                    Text(primaryButtonText)
                        .applyStyle(style: .buttonTitleStyle)
                    Spacer()
                }
                .applyStyle(style: .multiplePrimary)
                .frame(width: abs((geometry.size.width-16)/3*2))
                
                Button {
                    dismiss()
                } label: {
                    Spacer()
                    Text(secondaryButtonText)
                        .applyStyle(style: .buttonTitleStyleSecondary)
                    Spacer()
                }
                .applyStyle(style: .multipleSecondary)
                .frame(width: abs((geometry.size.width-16)/3*1))
                
            }
            
            .frame(maxWidth: .infinity)
        }
    }
}

struct TwoButtonsView_Previews: PreviewProvider {
    @Environment(\.dismiss) static var dismiss

    static var previews: some View {
        TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle, secondaryButtonText: LocalizedString.Buttons.previousTitle, dismiss: dismiss, primaryAction: {})
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
