//
//  CardDisplayModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CardDisplayModel: Identifiable, Hashable {
    static func == (lhs: CardDisplayModel, rhs: CardDisplayModel) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var title: LabelDisplayModel
    var subtitle: LabelDisplayModel
    var count: LabelDisplayModel
    var color: Color
    var backgroundColor: Color
    let state: CardState
    var progress: Float
    var id: String
    var recordID: String?
}

enum CardState {
    case wip
    case done
    case quit
    case quitWip
    
    var iconName: String {
        switch self {
        case .wip:
            return "plus"
        case .done:
            return "done"
        case .quit:
            return "stop"
        case .quitWip:
            return "stop_wip"
        }
    }
}
