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
            TextView(model: item.title)
            Spacer()
            Image(item.selected ? "Activated_on" : "Activated_off")
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: PublicTheme.cornerRaduis)
                    .stroke(Color.borderColor, lineWidth: 1))
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
