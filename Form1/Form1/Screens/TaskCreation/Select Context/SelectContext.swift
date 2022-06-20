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
        VStack(spacing: 20) {
            Spacer()
            
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
            .padding([.leading, .trailing], 24)
            
            List(viewModel.items, id: \.id) { item in
                SelectContextCell(item: item)
                    .padding([.vertical], 10)
                    .background(PublicTheme.background)
            }
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
                UITableView.appearance().backgroundColor = .clear
                UIScrollView.appearance().keyboardDismissMode = .onDrag
            })
        }
        .background(PublicTheme.background)
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

