//
//  CircularProgressView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-30.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Float
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    PublicTheme.contextBackgroundColor,
                    lineWidth: 16
                )
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    color,
                    style: StrokeStyle(
                        lineWidth: 16,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-270))
                .animation(.easeOut, value: progress)
            
        }
    }
}


struct WeekCircleView: View {
    let todayProgress: Float
    let weekProgress: Float
    
    var body: some View {
        ZStack {
            CircularProgressView(progress: todayProgress,
                                 color: PublicTheme.primaryColor)
                .frame(width: 144, height: 144)
            
            CircularProgressView(progress: weekProgress,
                                 color: PublicTheme.greenColor)
                .frame(width: 80, height: 80)
        }
    }
}
