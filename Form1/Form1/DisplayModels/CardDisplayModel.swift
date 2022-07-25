//
//  CardDisplayModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 3/1/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct CardDisplayModel {
    var title: LabelDisplayModel
    var subtitle: LabelDisplayModel
    var count: LabelDisplayModel
    let background: Color
    let state: CardState
    var progress: Float
    var id: String
}

enum CardState {
    case wip
    case done
    case over
}
