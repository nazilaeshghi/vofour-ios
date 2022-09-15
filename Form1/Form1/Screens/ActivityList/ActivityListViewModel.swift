//
//  ActivityListViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

class ActivityListViewModel: ObservableObject {
    private let dataManager: ActivityListDataManagable
    @Published var selectedType: Int = 0
    
    init(dataManager: ActivityListDataManagable) {
        self.dataManager = dataManager
    }
    
    var segmentItems: [String] {
        return [
            LocalizedString.ActicityList.golas,
            LocalizedString.ActicityList.contexts
        ]
    }
}


struct ActiviyListSectionCard: Identifiable {
    var id: String
    var title: LabelDisplayModel
    var iconName: String?
    var items: [ActiviyListItemCard]
}

struct ActiviyListItemCard: Identifiable {
    var id: String
    var title: LabelDisplayModel
    var subtitle: LabelDisplayModel
    var color: Color
    var progress: Float
    var taskId: String
}
