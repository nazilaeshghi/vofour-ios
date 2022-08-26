//
//  CardUIView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/13/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CardUIView: View {
    @Binding private (set) var viewModel: CardDisplayModel
    let increamentAction: () -> Void
    let detailAction: () -> Void
    
    var body: some View {
            ZStack {
                ProgressBar(value: $viewModel.progress,
                            color: viewModel.background)
                
                HStack {
                    CardTitleStackView(title: viewModel.title,
                                       subtitle: viewModel.subtitle)
                    
                    Spacer()
                    
                    Image(viewModel.state.iconName)
                        .foregroundColor(.white)
                    
                }
                .padding()
                
                GeometryReader { geometry in
                    HStack (alignment: .bottom) {
                        Button(action: {
                            detailAction()
                        }, label: {
                            Text(" ")
                                .frame(width: geometry.size.width * 0.75)
                                .frame(height: 70)
                        })
                            .buttonStyle(BorderlessButtonStyle())
                        
                        Button(action: {
                            increamentAction()
                        }, label: {
                            Text(" ")
                                .frame(width: geometry.size.width * 0.25)
                                .frame(height: 70)
                        })
                            .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .frame(height: 70)
            }
            .frame(height: 70)
            .cornerRadius(PublicTheme.cornerRaduis)
            .applyBasicCellStyle()
    }
}

struct CardUIView_Previews: PreviewProvider {
    static var previews: some View {
        CardUIView(viewModel: .constant(CardMockGenerator.sample1()),
                   increamentAction: {},
                   detailAction: {})
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct CardMockGenerator {
    static func sample1() -> CardDisplayModel {
        return CardDisplayModel(title: LabelDisplayModel(plainText: "نیم ساعت پیاده‌روی"),
                                subtitle: LabelDisplayModel(plainText: "این هفته: ۴ بار", style: .secondaryRegularSubtitle),
                                count: LabelDisplayModel(plainText: "۳", style: .regularTitle),
                                background: Color(hex:"EA4C89"),
                                state: .done,
                                progress: 0.5,
                                id: "taskID")
    }
}
