//
//  GoalDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol Goal {
    var id: String { get }
    var title: String { get }
}

struct GoalEntity: Goal {
    var id: String
    var title: String
}

struct SelectGoalDisplayModel {
    let id: String
    let title: LabelDisplayModel
    let imageName: String = "Flag"
    let selected: Bool
}
