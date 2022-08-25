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
                .strokeBorder(
                    PublicTheme.contextBackgroundColor,
                    lineWidth: 16
                )
                
            Circle()
                .trim(from: 0, to: progress.isNaN ? 0 : CGFloat(progress))
                .stroke(
                    color,
                    style: StrokeStyle (
                        lineWidth: 16,
                        lineCap: .round,
                        miterLimit: 5
                    )
                )
                .rotationEffect(.degrees(-270))
                .animation(.easeOut, value: progress)
                .padding(8)
        }
    }
}


struct CircularProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView(progress: 0.75, color: .red)
    }
}
