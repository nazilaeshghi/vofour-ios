//
//  HomeView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ContextListView: View {
    @StateObject var viewModel: SelectContextViewModel
    
    @State private var showingSheet = false
    @State private var searchText: String = ""
    
    @State private var selectedContextID: String?
    
    let columns = [GridItem(.adaptive(minimum: 120), spacing: PublicTheme.collectionSpace)]
    
    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace) {
            Group {
                SearchBar(searchText: $searchText)
                
                List($viewModel.items, id: \.id) { item in
                    SelectContextCell(item: item)
                        .onTapGesture {
                            selectedContextID = item.contextID.wrappedValue
                        }
                }
                .applyListBasicStyle()
            }
            .applyBasicViewStyle()
        }
        .onAppear(perform: {
            viewModel.fetchContexts()
        })
        .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
            viewModel.fetchContexts()
        }
        .background(Color.background)
        .sheet(item: $selectedContextID) { contextID in
            AppCoordinator.shared.makeTaskCreationStep1View(contextID: contextID)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = SelectContextDataManagableMock()
        let viewModel = SelectContextViewModel(dataManager: dataManager)
        ContextListView(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
