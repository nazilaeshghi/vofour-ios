//
//  ActivityListCellView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct ActivityListCellView: View {
    let item: ActiviyListItemCard
    let hideProgress: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Text(item.title.plainText)
                        .applyStyle(style: item.title.labelStyle)
                    
                    Text(LocalizedString.TaskDetail.quit)
                        .applyStyle(style: .regularBody)
                        .padding(4)
                        .background(Color.textBackground)
                        .cornerRadius(4, corners: .allCorners)
                        .isHidden(!item.isQuit)
                }
                
                HStack {
                    if let iconName = item.iconName {
                        Image(iconName)
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.headerSecondaryTextColor)
                    }
                    
                    Text(item.subtitle.plainText)
                        .applyStyle(style: item.subtitle.labelStyle)
                        .frame( height: 16)
                    
                    
                    Spacer()
                }
            }
            
            if let progress = item.progress, !hideProgress {
                Spacer()
                
                ZStack {
                    Text(progress.relativePercentageString)
                        .applyStyle(style: .regularTinyBody)
                    CircularProgressView(progress: progress,
                                         color: item.color,
                                         lineWidth: 2)
                        .frame(width: 40, height: 40)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .frame(height: 72)
        .background(.white)
        .cornerRadius(PublicTheme.cornerRaduis)
        .padding(.horizontal, 1)
    }
}

struct ActivityListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityListCellView(item: ActiviyListItemCard(id: "sfsf",
                                                       title: LabelDisplayModel(plainText: "نیم ساعت پیاده‌روی", style: .regularMediumTitle),
                                                       subtitle: LabelDisplayModel(plainText: "ورزش", style: .regularSubtitle),
                                                       color: Color.red,
                                                       progress: 0.5,
                                                       iconName: "context_awakeness",
                                                       isQuit: true),
                             hideProgress: false)
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}

extension Float {
    var relativePercentageString: String {
        return ("%" + String(Int(self * 100))).convertToPersian()
    }
}
