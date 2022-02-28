//
//  CardUIView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/13/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct PublicTheme {
    static let cornerRaduis : CGFloat = 16
}

struct CardUIView: View {
    
    let viewModel: CardViewModel
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    let imageName =  viewModel.state == .done ? "checkmark" : "plus"
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                    Text(viewModel.count)
                        .scaledFont(style: .title2)
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Spacer()
                        Text(viewModel.title)
                            .scaledFont(style: .title)
                    }
                            
                    HStack {
                        Spacer()
                        Text(viewModel.subtitle)
                            .scaledFont(style: .subtitle)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding()
            .background(viewModel.background)
            .cornerRadius(PublicTheme.cornerRaduis)
        }
    }
}

struct CardUIView_Previews: PreviewProvider {
    static var previews: some View {
        CardUIView(viewModel: CardMockGenerator.sample1())
    }
}

struct CardViewModel {
    let title: String
    let subtitle: String
    let count: String
    let background: Color
    let state: CardState
}

enum CardState {
    case wip
    case done
    case over
}

struct CardMockGenerator {
    
    static func sample1() -> CardViewModel {
        return CardViewModel(title: "نیم ساعت پیاده‌روی",
                             subtitle: "این هفته: ۴ بار",
                             count: "۲",
                             background: Color(hex:"EA4C89"),
                             state: .done)
    }
}
