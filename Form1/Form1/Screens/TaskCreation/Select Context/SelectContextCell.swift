//
//  SelectContextCell.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 4/26/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct SelectContextCell: View {
    @Binding var item: ContextItemDisplayModel
    
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
        .if(item.isSelected, transform: { view in
            view.overlay(
                    RoundedRectangle(cornerRadius: PublicTheme.cornerRaduis)
                        .strokeBorder(Color.primaryColor, lineWidth: 1)
                )
        })
        
    }
}

struct SelectContextCell_Previews: PreviewProvider {
    static var previews: some View {
        SelectContextCell(item: .constant(SelectContextCellMockGenerator.item))
            .environment(\.layoutDirection, .rightToLeft)
    }
}

