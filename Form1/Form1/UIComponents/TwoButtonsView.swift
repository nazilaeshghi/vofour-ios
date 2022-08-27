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

    let primaryAction: () -> Void
    let secondaryAction: () -> Void
    
    let destructive: Bool
        
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: PublicTheme.buttonSpacing) {
                Button {
                    primaryAction()
                } label: {
                    Spacer()
                    Text(primaryButtonText)
                        .applyStyle(style: .brightRegularTitle)
                    Spacer()
                }
                .applyStyle(style: .multiplePrimary)
                .frame(width: abs((geometry.size.width - PublicTheme.buttonSpacing) / 4 * 3))
                
                Button {
                    secondaryAction()
                } label: {
                    Spacer()
                    Text(secondaryButtonText)
                        .applyStyle(style: destructive ? .destructiveTitle : .primaryTitle)
                    Spacer()
                }
                .applyStyle(style: .multipleSecondary)
                .frame(width: abs((geometry.size.width - PublicTheme.buttonSpacing) / 4))
            }
            .frame(height: PublicTheme.buttonHeight, alignment: .center)
        }
        .frame(height: PublicTheme.buttonHeight, alignment: .center)
        .padding(.vertical, PublicTheme.buttonSpacing)
    }
}

struct TwoButtonsView_Previews: PreviewProvider {

    static var previews: some View {
        TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle, secondaryButtonText: LocalizedString.Buttons.previousTitle, primaryAction: {}, secondaryAction: {}, destructive: false)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
