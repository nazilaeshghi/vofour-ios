//
//  SelectContext.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContext: View {
    let items: [ContextItemDisplayModel]
    @State var searchText = ""
    
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
                }
            }
            .padding([.leading, .trailing], 24)
            
            List(items, id: \.id) { item in
                SelectContextCell(item: item)
                    .padding([.vertical], 10)
                    .background(PublicTheme.background)
            }
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
                UITableView.appearance().backgroundColor = .clear
            })
        }
        .background(PublicTheme.background)
    }
}

struct SelectContext_Previews: PreviewProvider {
    static var previews: some View {
        SelectContext(items: SelectContextCellMockGenerator.items)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}

