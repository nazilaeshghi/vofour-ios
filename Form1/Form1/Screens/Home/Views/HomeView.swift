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
    @State private var showingTaskCreationSheet = false
    
    @State private var selectedContextID: String?
    @State private var sevenDays: [HeaderDayObject] = DateBuilder.make7Days(selectedDate: Date())
    
    let columns = [GridItem(.adaptive(minimum: 120), spacing: PublicTheme.collectionSpace)]
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                
                // Header and progress overview
                HomeHeaderView(sevenDays: sevenDays)
                ProgressOverViewOverview(todayProgress: viewModel.todayProgress,
                                         weekProgress: viewModel.weekProgress)
                
                // Contexts grid
                Text(LocalizedString.Home.contextTitle)
                    .applyStyle(style: .deselectedButtonTitleStyle)
                
                Spacer()
                
                LazyVGrid(columns: columns, spacing: PublicTheme.collectionSpace) {
                    ForEach($viewModel.contexs, id: \.id) { item in
                        HomeContextCellView(item: item)
                            .onTapGesture {
                                showingTaskCreationSheet = true
                                selectedContextID = item.contextID.wrappedValue
                            }
                    }
                }
            }
            .applyBasicViewStyle()
            .applyScrollViewPadding()
            .onAppear(perform: {
                viewModel.fetchData()
            })
            .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
                viewModel.fetchData()
                sevenDays = DateBuilder.make7Days(selectedDate: Date())
            }
        }
        .background(.background)
        .sheet(item: $selectedContextID) { contextID in
            AppCoordinator.shared.makeTaskCreationStep1View(contextID: contextID)
        }
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
