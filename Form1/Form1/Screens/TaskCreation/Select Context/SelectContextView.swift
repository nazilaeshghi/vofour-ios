//
//  SelectContext.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContextView: View {
    @StateObject var viewModel: SelectContextViewModel
    @State private var searchText: String = ""
    @State private var linkIsActive: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(isActive: $linkIsActive) {
                    AppCoordinator.shared.makeTaskCreationStep1View()
                } label: {
                    EmptyView()
                }.opacity(0)
                
                VStack(spacing: PublicTheme.vHeaderSpace) {
                    DeviderView()
                    
                    Group {
                        SelectContextHeaderView(searchText: $searchText)
                            .onChange(of: searchText) { newValue in
                                viewModel.filterContextas(with: searchText)
                            }
                        
                        List(viewModel.items, id: \.id) { item in
                            SelectContextCell(item: item)
                                .onTapGesture {
                                    linkIsActive = true
                                    viewModel.selectContext(id: item.contextID)
                                }
                        }
                        .applyListBasicStyle()
                    }
                    .applyBasicViewStyle()
                }
            }
            .applyBackgroundColor()
            .applyToolbarStyle(with: LocalizedString.ContextPage.header, action: {
                presentationMode.wrappedValue.dismiss()
            })
            .onReceive(NotificationCenter.default.publisher(for: .cloceClick))
            { obj in
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct SelectContext_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = SelectContextDataManagableMock()
        let viewModel = SelectContextViewModel(dataManager: dataManager)
        SelectContextView(viewModel: viewModel)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}


struct SelectContextHeaderView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: PublicTheme.vHeaderSpace) {
            HStack {
                Text(LocalizedString.ContextPage.subHeader)
                    .applyStyle(style: .primaryMediumTitle)
                Spacer()
            }
            
            VStack(spacing: PublicTheme.inputCellSpacing) {
                HStack {
                    Text(LocalizedString.ContextPage.searchHeader)
                        .applyStyle(style: .regularSubtitle)
                    Spacer()
                }
                SearchBar(searchText: $searchText)
            }
        }
    }
}

