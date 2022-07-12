//
//  ModalHeaderView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-12.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ModalHeaderView: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                Text(title)
                    .applyStyle(style: LabelStyle.number)
                HStack {
                    Spacer()
                    Button(action: {
                        action()
                    }) { Image("close") }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
            }
            Divider()
        }
    }
}
