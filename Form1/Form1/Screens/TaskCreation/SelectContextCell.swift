//
//  SelectContextCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContextCell: View {
    let item: ContextItemDisplayModel
    
    var body: some View {
        HStack {
            Image(item.imageName)
            Text(item.title.plainText)
                .applyStyle(style: item.title.labelStyle)
            Spacer()
            Image("Arrow")
        }
        .padding()
        .background(PublicTheme.contextBackgroundColor)
        .cornerRadius(PublicTheme.cornerRaduis)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}

struct SelectContextCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectContextCell(item: SelectContextCellMockGenerator.item)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SelectContextCellMockGenerator {
    
    static var item: ContextItemDisplayModel {
        return ContextItemDisplayModel(title: LabelDisplayModel(plainText: "خود شخصی (۲)",
                                                                style: .smallTitleStyle),
                                       imageName: "Users_Context")
    }
    
    static var items: [ContextItemDisplayModel] {
        return [SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item]
    }
}

