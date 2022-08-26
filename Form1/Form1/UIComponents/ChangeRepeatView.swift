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
    let title: String
    
    var body: some View {
        VStack(spacing: PublicTheme.inputCellSpacing) {
            InputCellTitleView(title: title)
            
            HStack {
                Button {
                    repeatNum = repeatNum + 1
                } label: {
                    Text("+")
                        .applyStyle(style: .primaryRegularMediumTitle)
                }
                .padding(EdgeInsets(top: 5, leading: 15, bottom: 0, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(repeatNum)".convertToPersian() + "بار")
                    .applyStyle(style: .regularTitle)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    repeatNum = ((repeatNum - 1) == 0) ? 1 : (repeatNum - 1)
                } label: {
                    Text("-")
                        .applyStyle(style: .primaryRegularMediumTitle)
                }
                .padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 15))
                .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            .frame(height: 40)
            .overlay(
                RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                    .stroke(Color.borderColor, lineWidth: 1)
            )
        }
    }
}

struct RepeaterView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeRepeatView(repeatNum: .constant(1), title: LocalizedString.Input.numberOfRepeatTitle)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
    }
}
