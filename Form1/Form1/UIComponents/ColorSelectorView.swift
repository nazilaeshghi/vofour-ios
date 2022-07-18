//
//  ColorSelectorView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ColorSelectorView: View {
    @Binding var selectedColor: String
    
    let colors = StaticColors.colors
    
    var body: some View {
        VStack(spacing: PublicTheme.formInputPadding) {
            InputCellTitleView(title: LocalizedString.Input.color)
            
            ScrollView(.horizontal) {
                HStack(spacing: 5) {
                    ForEach(colors.reversed(), id: \.self) { item in
                        ZStack {
                            Button("") {}
                            .frame(width: 38, height: 38)
                            .background(Color(hex: item))
                            .cornerRadius(19)
                            .onTapGesture {
                                selectedColor = item
                            }
                            
                            if selectedColor == item {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(hex: "#0b2959"), lineWidth: 2)
                                    )
                                    .frame(width: 42, height: 42)
                                    .padding(3)
                                    .background(.clear)
                                    .disabled(true)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView(selectedColor: .constant("#F6C94A"))
    }
}

struct StaticColors {
    static let colors = ["#EA4C89","#57B587","#F6C94A","#C49CF2","#FF7979","#AAD9CD","#FAC3B6","#67AEEE"]
}
