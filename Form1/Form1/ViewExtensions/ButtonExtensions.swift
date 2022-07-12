//
//  ButtonExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

enum ButtonType {
    case singel
    case multiple
}

extension Button {
    func applyStyle(style: CustomButtonStyle) -> some View {
        self
            .padding(EdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4))
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
            .cornerRadius(style.cornerRaduis)
            .frame(height: style.height)
    }
    
    func applyNoPaddingStyle(style: CustomButtonStyle) -> some View {
        self
            .foregroundColor(style.textColor)
            .background(style.backgroundColor)
    }
}

struct TwoButtonView: View {
    var primaryButtonText: String
    var secondaryButtonText: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Button {
                    
                } label: {
                    Spacer()
                    Text(primaryButtonText)
                        .applyStyle(style: .buttonTitleStyle)
                    Spacer()
                }
                .applyStyle(style: .multiplePrimary)
                .frame(width: (geometry.size.width-40)/3*2)
                
                Button {
                    
                } label: {
                    Spacer()
                    Text(secondaryButtonText)
                        .applyStyle(style: .buttonTitleStyleSecondary)
                    Spacer()
                }
                .applyStyle(style: .multipleSecondary)
                .frame(width: (geometry.size.width-40)/3*1)

            }
            .padding(20)
        }
    }
}

struct TwoButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TwoButtonView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle, secondaryButtonText: LocalizedString.Buttons.previousTitle)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

