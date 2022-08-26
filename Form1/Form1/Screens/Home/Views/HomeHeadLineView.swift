//
//  HomeHeadLineView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct HomeHeadLineView: View {
    var todayProgress: Float
    var weekProgress: Float
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: PublicTheme.vHeaderSpace) {
            VStack(alignment: .leading, spacing: .zero) {
                
                if let week = Int(weekProgress * 100), week >= 0 {
                    Text("%\(week)".convertToPersian())
                        .applyStyle(style: .primaryRegularLargTitle)
                } else {
                    Text("---")
                        .applyStyle(style: .primaryRegularLargTitle)
                }
                
                HStack {
                    Image.blueDot
                    Text(LocalizedString.Home.todayProgress)
                        .applyStyle(style: .primaryRegularBody)
                }
            }
            
            VStack(alignment: .leading, spacing: .zero) {
                
                if let today = Int(todayProgress * 100), today >= 0 {
                    Text("%\(today)".convertToPersian())
                        .applyStyle(style: .greenRegularLargTitle)
                } else {
                    Text("---")
                        .applyStyle(style: .greenRegularLargTitle)
                }
                    
                HStack {
                    Image.greenDot
                    Text(LocalizedString.Home.weekProgress)
                        .applyStyle(style: .greenRegularBody)
                }
            }
        }
       
    }
}

struct HomeHeadLineView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeadLineView(todayProgress: 0.6, weekProgress: 0.3)
    }
}
