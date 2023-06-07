//
//  TaskDetailsRowView.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-07.
//  Copyright © 2023 Vofour. All rights reserved.
//

import SwiftUI

struct TaskDetailsRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .applyStyle(style: .mediumSubtitle)
                .layoutPriority(1)
                .lineLimit(3)
            
            CustomLineShapeWithAlignment(stratPoint: .trailing, endPoint: .leading)
                .stroke(Color.primaryTextColor, style: StrokeStyle(lineWidth: 1.0, dash: [4]))
                .frame(height: 1.0)
                .frame(minWidth: 20)
            
            Text(value)
                .applyStyle(style: .regularSubtitle)
                .layoutPriority(1)
                .lineLimit(3)
        }
    }
}
struct TaskDetailsRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsRowView(title: "ksdjskf", value: "asbfhkasbfj,asbfjabsfkas faskfjasf askjf asjnchasdjas")
    }
}
