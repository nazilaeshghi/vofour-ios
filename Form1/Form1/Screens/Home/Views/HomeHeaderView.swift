//
//  HomeHeaderView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct HomeHeaderView: View {
    var sevenDays: [HeaderDayObject]
    @State private var showingSheet = false
    let dateHelper = DateHelper()
    
    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(dateHelper.getRelativeDate(from: sevenDays.first?.date, to: sevenDays.last?.date))
                    .applyStyle(style: .secondaryRegularBody)
                
                Text(dateHelper.getFullDatestring())
                    .applyStyle(style: .mediumSubtitle)
            }
            
            Spacer()
            
            Button(action: {
                showingSheet = true
            }, label: {
                Image.settings
            })
                .frame(width: 30, height: 30)
        }
        .sheet(isPresented: $showingSheet, onDismiss: {
            showingSheet = false
        }) {
            SettingsView(isPresented: $showingSheet)
        }
    }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView(sevenDays: DateBuilder.make7Days(selectedDate: Date()))
    }
}
