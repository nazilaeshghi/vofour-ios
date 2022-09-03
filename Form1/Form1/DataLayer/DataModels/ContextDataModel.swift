//
//  ContextDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskContext {
    var id: String { get }
    var name: String { get }
    var iconName: String { get }
}

class ContextItemDisplayModel: ObservableObject {

    init(title: LabelDisplayModel, imageName: String, contextID: String, isSelected: Bool) {
        self.id = UUID()
        self.title = title
        self.imageName = imageName
        self.contextID = contextID
        self.isSelected = isSelected
    }
    
    let id: UUID
    var title: LabelDisplayModel
    var imageName: String
    var contextID: String
    var isSelected: Bool
}
