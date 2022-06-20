//
//  SelectGoalView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/21/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectGoalView: View {
    let items: [SelectGoalDisplayModel]
    let defaultItem: SelectGoalDisplayModel
    
    var body: some View {
        VStack {
            List {
                Section {
                    SelectGoalCell(item: defaultItem)
                        .padding([.vertical], 10)
                        .background(PublicTheme.background)
                }
                
                if !items.isEmpty{
                    Section(header: Text(LocalizedString.SelectGoalPage.sectionHeader)
                                .applyStyle(style: .sectionHeaderStyle)) {
                        ForEach(items, id: \.id) { item in
                            SelectGoalCell(item: item)
                                .padding([.vertical], 10)
                                .background(PublicTheme.background)
                        }
                    }
                }
            }
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
                UITableView.appearance().backgroundColor = .clear
            })
            .background(PublicTheme.background)
            
            Button {
                
            } label: {
                Text(LocalizedString.SelectGoalPage.buttonTitle)
                    .applyStyle(style: .buttonTitleStyle)
            }
            .applyStyle(style: .primary)
            
            Spacer()
            
        }
        .background(PublicTheme.background)
    }
}

struct SelectGoalView_Previews: PreviewProvider {
    static var previews: some View {
        SelectGoalView(items: SelectGoalCellMockGenerator.items, defaultItem: SelectGoalCellMockGenerator.defaultItem)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
