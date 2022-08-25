//
//  ProgressOverViewOverView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ProgressOverViewOverview: View {
    var todayProgress: Float
    var weekProgress: Float
    
    var body: some View {
        HStack (spacing: PublicTheme.containerPadding) {
            WeekCircleView(todayProgress: todayProgress,
                           weekProgress: weekProgress)
            HomeHeadLineView(todayProgress: todayProgress,
                             weekProgress: weekProgress)
        }
        .frame(maxWidth: .infinity,
               alignment: .topLeading)
        .padding(PublicTheme.containerPadding)
        .background(.white)
        .cornerRadius(PublicTheme.inputTextCornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}

struct ProgressOverViewOverView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressOverViewOverview(todayProgress: 0.5, weekProgress: 0.6)
    }
}
