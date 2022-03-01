//
//  CardUIView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/13/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CardUIView: View {
    @State private (set) var viewModel: CardDisplayModel
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ProgressBar(value: $viewModel.progress,
                            color: viewModel.background)
                    .frame(height: geometry.size.height)
                
                HStack {
                    CardTitleStackView(title: viewModel.title,
                                       subtitle: viewModel.subtitle)
                    
                    Spacer()
                    
                    HStack {
                        Text(viewModel.count.plainText)
                            .applyStyle(style: viewModel.count.labelStyle)
                        
                        let imageName =  viewModel.state == .done ? "checkmark" : "plus"
                        Image(systemName: imageName)
                            .foregroundColor(.white)
                    }
                }
                .padding()
            }
            .cornerRadius(PublicTheme.cornerRaduis)
            .padding()
        }
    }
}

struct CardUIView_Previews: PreviewProvider {
    static var previews: some View {
        CardUIView(viewModel: CardMockGenerator.sample1())
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
                             progress: 0.3)
    }
}
