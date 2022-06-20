//
//  WeekDaysView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct WeekDaysView: View {
    
    let weekDays = ["ش","ی","د","س","چ","پ","ج"]
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(LocalizedString.Input.whichDays)
                    .applyStyle(style: .sectionHeaderStyle)
                Spacer()
            }
            
            HStack(spacing: 10) {
                    ForEach(weekDays, id: \.self) { day in
                        Button {
                            
                        } label: {
                            Text(day)
                                .applyStyle(style: .buttonTitleStyle)
                        }
                        .applyNoPaddingStyle(style: .multiplePrimary)
                        .frame(width: 38, height: 38)
                        .background(PublicTheme.primaryColor)
                        .cornerRadius(19)
                    }
            }
        }
    }
}

struct WeekDaysView_Previews: PreviewProvider {
    static var previews: some View {

        WeekDaysView()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        
        WeekDaysView()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
        
        WeekDaysView()
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro Max"))

    }
}
