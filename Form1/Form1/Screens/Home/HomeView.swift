//
//  HomeView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    @State private var showingSheet = false
    
    let dateHelper = DateHelper()
    @State var sevenDays: [HeaderDayObject] = DateBuilder.make7Days(selectedDate: Date())
    
    let columns = [
            GridItem(.adaptive(minimum: 120), spacing: 20)
        ]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text(dateHelper.getPersianRelativeDate(from: sevenDays.first?.date, to: sevenDays.last?.date))
                            .applyStyle(style: .verySmallHeaderStyle)
                        
                        Text(dateHelper.getTodayPersianFullDate())
                            .applyStyle(style: .sectionHeaderStyle)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showingSheet = true
                    }, label: {
                        Image("settings")
                    })
                    .frame(width: 30, height: 30)
                }
                HomeOverView(todayProgress: viewModel.todayProgress,
                             weekProgress: viewModel.weekProgress)
                
                Text(LocalizedString.Home.contextTitle)
                    .applyStyle(style: .deselectedButtonTitleStyle)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.contexs, id: \.id) { item in
                        HomeContextCellView(item: item)
                    }
                }
            }
            .padding(24)
            .background(PublicTheme.background)
            .onAppear(perform: {
                viewModel.fetchData()
            })
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.saveClick)) { obj in
                viewModel.fetchData()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.tabClick)) { obj in
                viewModel.fetchData()
            }
            .sheet(isPresented: $showingSheet, onDismiss: {
                viewModel.fetchData()
                sevenDays = DateBuilder.make7Days(selectedDate: Date())
                showingSheet = false
            }) {
                SettingsView()
            }
        }
        .background(PublicTheme.background)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = HomeDataManagerMock()
        let viewModel = HomeViewModel(dataManager: dataManager)
        HomeView(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

struct HomeHeadLineView: View {
    var todayProgress: Float
    var weekProgress: Float
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 0) {
                let week = Int(weekProgress.isNaN ? 0 : weekProgress * 100)
                Text("%\(week)".convertToPersian())
                    .applyStyle(style: .bigNumberStyle)
                HStack {
                    Image("blueDot")
                    Text(LocalizedString.Home.todayProgress)
                        .applyStyle(style: .tabbarStyle)
                }
            }
            
            VStack(alignment: .leading, spacing: 0) {
                let today = Int(todayProgress.isNaN ? 0 : todayProgress * 100)
                Text("%\(today)".convertToPersian())
                    .applyStyle(style: .bigGreenNumberStyle)
                    
                HStack {
                    Image("greenDot")
                    Text(LocalizedString.Home.weekProgress)
                        .applyStyle(style: .verySmallGreenNumberStyle)
                }
            }
        }
       
    }
}

struct HomeOverView: View {
    var todayProgress: Float
    var weekProgress: Float
    
    var body: some View {
        HStack (spacing: 20){
            WeekCircleView(todayProgress: todayProgress,
                           weekProgress: weekProgress)
            HomeHeadLineView(todayProgress: todayProgress,
                             weekProgress: weekProgress)
        }
        .frame(maxWidth: .infinity,
               alignment: .topLeading)
        .padding(24)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: PublicTheme.inoutTextCornerRadius)
                .stroke(PublicTheme.borderColor, lineWidth: 1)
        )
    }
}
