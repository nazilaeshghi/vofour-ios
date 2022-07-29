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
    
    var body: some View {
            ZStack {
                ProgressBar(value: $viewModel.progress,
                            color: viewModel.background)
                
                HStack {
                    CardTitleStackView(title: viewModel.title,
                                       subtitle: viewModel.subtitle)
                    
                    Spacer()
                    
                    ZStack(alignment: .trailing) {
                        Image(viewModel.state.iconName)
                            .foregroundColor(.white)
                        
                        Button(" ") {
                            increamentAction()
                        }.frame(width: 100, height: 70)
                    }
                    
                }
                .padding()
            }
            .frame(height: 70)
            .cornerRadius(PublicTheme.cornerRaduis)
    }
}

struct CardUIView_Previews: PreviewProvider {
    static var previews: some View {
        CardUIView(viewModel: .constant(CardMockGenerator.sample1())  , increamentAction: {})
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct CardMockGenerator {
    static func sample1() -> CardDisplayModel {
        return CardDisplayModel(title: LabelDisplayModel(plainText: "نیم ساعت پیاده‌روی"),
                                subtitle: LabelDisplayModel(plainText: "این هفته: ۴ بار", style: .subtitleStyle),
                                count: LabelDisplayModel(plainText: "۳", style: .number),
                                background: Color(hex:"EA4C89"),
                                state: .done,
                                progress: 1,
                                id: "taskID")
    }
}
