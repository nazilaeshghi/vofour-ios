//
//  ProgressBar.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    var color: Color
    var backgroundcolor: Color
    
    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width , height: geometry.size.height)
                .foregroundColor(backgroundcolor)
            
            let progressValue = min(CGFloat(self.value) * geometry.size.width, geometry.size.width)
            
            Rectangle().frame(width: progressValue,
                              height: geometry.size.height)
                    .foregroundColor(color)
        }
    }
}
