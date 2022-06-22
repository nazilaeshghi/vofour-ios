//
//  TaskCreationStep1ViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskCreationStep1ViewModel: ObservableObject {
    private let dataManager: TaskCreationStep1DataManagable
    
    init(dataManager: TaskCreationStep1DataManagable) {
        self.dataManager = dataManager
    }
    
    func header() -> String {
        return LocalizedString.TaskCreationStep1.header(context: dataManager.getContextName())
    }
}
