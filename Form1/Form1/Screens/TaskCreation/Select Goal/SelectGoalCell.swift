//
//  SelectGoalCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/21/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectGoalCell: View {
    let item: SelectGoalDisplayModel
    
    var body: some View {
        HStack {
            Image(item.imageName)
            Text(item.title.plainText)
                .applyStyle(style: item.title.labelStyle)
            Spacer()
            Image(item.selected ? "Activated_on" : "Activated_off")
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: PublicTheme.cornerRaduis)
                    .stroke(PublicTheme.borderColor, lineWidth: 1))
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
}

struct SelectGoalCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectGoalCell(item: SelectGoalCellMockGenerator.item)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

struct SelectGoalCellMockGenerator {
    
    static var item: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "مسابقات معماری (۳ فعالیت)",
                                            style: .smallTitleStyle)
        return SelectGoalDisplayModel(title: titleModel,
                                      selected: true)
    }
    
    static var unselectedItem: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "مسابقات معماری (۳ فعالیت)",
                                            style: .smallTitleStyle)
        return SelectGoalDisplayModel(title: titleModel,
                                      selected: false)
    }
    
    static var defaultItem: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "هدف ندارد و مستقل است (۲ فعالیت)",
                                            style: .smallTitleStyle)
        return SelectGoalDisplayModel(title: titleModel,
                                      selected: false)
    }
    
    static var items: [SelectGoalDisplayModel] {
        return [SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.unselectedItem,
                SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.item]
    }
}
