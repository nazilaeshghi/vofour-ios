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
                                 lineWidth: 16)
                .frame(width: 144, height: 144)
            
            CircularProgressView(progress: todayProgress,
                                 color: .greenColor,
                                 lineWidth: 16)
                .frame(width: 80, height: 80)
        }
    }
}

struct WeekCircleView_Previews: PreviewProvider {
    static var previews: some View {
        WeekCircleView(todayProgress: 0.5, weekProgress: 0.2)
    }
}
