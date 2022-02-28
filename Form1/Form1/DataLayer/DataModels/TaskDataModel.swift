//
//  TaskDataModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation


protocol TaskDataModel {
    var taskID: String { get }
}


class RealmTaskDataModel: TaskDataModel {
    var taskID: String = ""
}
