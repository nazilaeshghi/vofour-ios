//
//  RepeaterView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ChangeRepeatView: View {
    @Binding var repeatNum: Int
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(LocalizedString.Input.numberOfRepeatTitle)
                    .applyStyle(style: .sectionHeaderStyle)
                Spacer()
            }
            
            HStack {
                Button {
                    repeatNum = repeatNum + 1
                } label: {
                    Text("+")
                        .applyStyle(style: .operandStyle)
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(repeatNum) بار")
                    .applyStyle(style: .number)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    repeatNum = ((repeatNum - 1) == 0) ? 1 : (repeatNum - 1)
                } label: {
                    Text("-")
                        .applyStyle(style: .operandStyle)
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 15))
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .frame(height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: PublicTheme.inoutTextCornerRadius)
                    .stroke(PublicTheme.borderColor, lineWidth: 1)
            )
        }
    }
}

struct RepeaterView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeRepeatView(repeatNum: .constant(1))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
