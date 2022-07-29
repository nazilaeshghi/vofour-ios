//
//  HomeView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    let dateHelper = DateHelper()
    var sevenDays: [HeaderDayObject] = DateBuilder.make7Days(selectedDate: Date())
    
    var body: some View {
        VStack {
            HStack {
                VStack (alignment: .leading){
                    Text(dateHelper.getPersianRelativeDate(from: sevenDays.first?.date, to: sevenDays.last?.date))
                        .applyStyle(style: .verySmallHeaderStyle)
                    
                    Text(dateHelper.getTodayPersianFullDate())
                        .applyStyle(style: .sectionHeaderStyle)
                }
                Spacer()
            }
        }
        .padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
