//
//  HomeContextCellView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-29.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct HomeContextCellView: View {
    @Binding var item: HomeContextItemDisplayModel
    var body: some View {
        
        VStack {
            HStack {
                TextView(model: item.title)
                Spacer()
            }
            HStack {
                TextView(model: item.contextName)
                Spacer()
                Image.grayPlus
            }
        }
        .padding()
        .background(item.activityCount != 0 ? .white : Color.background)
        .cornerRadius(PublicTheme.cornerRaduis)
        .if(item.activityCount == 0, transform: { view in
            view.overlay(
                RoundedRectangle(cornerRadius: PublicTheme.inputTextCornerRadius)
                    .stroke(Color.borderColor, lineWidth: 1)
            )
        })
        
    }
}

struct HomeContextCellView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContextCellView(
            item: .constant( HomeContextItemDisplayModel(title:  LabelDisplayModel(plainText: "درآمد", style: .regularBody),
                                              imageName: "",
                                              contextID: "3456",
                                              contextName: LabelDisplayModel(plainText: " ا فعالیت", style: .secondaryRegularBody),
                                              activityCount: 2))
        )
    }
}

class HomeContextItemDisplayModel: ObservableObject {
    let id: UUID
    var title: LabelDisplayModel
    var imageName: String
    var contextID: String
    var contextName: LabelDisplayModel
    var activityCount: Int
    
    init(title: LabelDisplayModel,
         imageName: String,
         contextID: String,
         contextName: LabelDisplayModel,
         activityCount: Int) {
        self.id = UUID()
        self.title = title
        self.imageName = imageName
        self.contextID = contextID
        self.contextName = contextName
        self.activityCount = activityCount
    }
}
