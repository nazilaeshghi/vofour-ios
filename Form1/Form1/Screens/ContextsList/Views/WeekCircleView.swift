//
//  WeekCircleView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct WeekCircleView: View {
    let todayProgress: Float
    let weekProgress: Float
    
    var body: some View {
        ZStack {
            CircularProgressView(progress: weekProgress,
                                 color: .primaryColor,
                                 lineWidth: 3)
                .frame(width: 32, height: 32)
            
            CircularProgressView(progress: todayProgress,
                                 color: .greenColor,
                                 lineWidth: 3)
                .frame(width: 16, height: 16)
        }
    }
}

struct WeekCircleView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCircleView(todayProgress: 0.5, weekProgress: 0.2)
    }
}
