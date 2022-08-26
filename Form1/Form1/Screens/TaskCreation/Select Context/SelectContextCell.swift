//
//  SelectContextCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContextCell: View {
    @StateObject var item: ContextItemDisplayModel
    
    var body: some View {
        HStack {
            Image(item.imageName)
            Text(item.title.plainText)
                .applyStyle(style: item.title.labelStyle)
            Spacer()
            Image.arrow
        }
        .padding()
        .background(Color.contextBackgroundColor)
        .cornerRadius(PublicTheme.cornerRaduis)
        .applyBasicCellStyle()
    }
}

struct SelectContextCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectContextCell(item: SelectContextCellMockGenerator.item)
            .environment(\.layoutDirection, .rightToLeft)
    }
}

