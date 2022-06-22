//
//  SelectContext.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContext: View {
    @StateObject var viewModel: SelectContextViewModel
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Divider()
                
                // Page header, subheader and searchbar
                VStack(spacing: 14) {
                    HStack {
                        Text(LocalizedString.ContextPage.subHeader)
                            .applyStyle(style: LabelStyle.tableHeaderStyle)
                        Spacer()
                    }
                    
                    VStack(spacing: 6) {
                        HStack {
                            Text(LocalizedString.ContextPage.searchHeader)
                                .applyStyle(style: LabelStyle.smallTitleStyle)
                            Spacer()
                        }
                        SearchBar(searchText: $searchText)
                            .onChange(of: searchText) { newValue in
                                viewModel.filterContextas(with: searchText)
                            }
                    }
                }
                .padding([.leading, .trailing], 16)
                
                List(viewModel.items, id: \.id) { item in
                    ZStack {
                        NavigationLink(destination: AppCoordinator.shared.makeTaskCreationStep1View(selectedContextID: item.contextID)) {}
                        .opacity(0)
                        
                        SelectContextCell(item: item)
                            .background(PublicTheme.background)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .background(PublicTheme.background)
                .listStyle(PlainListStyle())
                .onAppear(perform: {
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
                })
            }
            .background(PublicTheme.background)
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarStyle(with: LocalizedString.ContextPage.header)
        }
    }
}

struct SelectContext_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = SelectContextDataManagableMock()
        let viewModel = SelectContextViewModel(dataManager: dataManager)
        SelectContext(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

