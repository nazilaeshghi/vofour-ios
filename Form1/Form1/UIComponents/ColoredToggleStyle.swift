//
//  ColoredToggleStyle.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-04.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

struct ColoredToggleStyle: ToggleStyle {
    var onColor = Color.primaryColor
    var offColor = Color(UIColor.systemGray5)
    var thumbColor = Color.white
    
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label // The text (or view) portion of the Toggle
            Spacer()
            RoundedRectangle(cornerRadius: 16, style: .circular)
                .fill(configuration.isOn ? onColor : offColor)
                .frame(width: 36, height: 20)
                .overlay(
                    Circle()
                        .fill(thumbColor)
                        .shadow(radius: 1, x: 0, y: 1)
                        .padding(1.5)
                        .offset(x: configuration.isOn ? -8 : 8))
                .animation(Animation.easeInOut(duration: 0.2))
                .onTapGesture { configuration.isOn.toggle() }
        }
        .font(.title)
        .padding(.horizontal)
    }
}
