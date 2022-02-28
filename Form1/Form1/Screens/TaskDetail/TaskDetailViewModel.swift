//
//  TaskDetailViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailViewModel: ObservableObject {
    
    private let dataManager: TaskDetailDataManagable
    
    init(dataManager: TaskDetailDataManagable) {
        self.dataManager = dataManager
    }
}
