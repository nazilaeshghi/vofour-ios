//
//  TaskCreationStep1DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol TaskCreationStep1DataManagable {
    func getContextName() -> String
}

class TaskCreationStep1DataManager: TaskCreationStep1DataManagable {
    private let dataManager: DataManager
    private let input: DataEntryDataModel
    
    init(dataManager: DataManager, input: DataEntryDataModel) {
        self.dataManager = dataManager
        self.input = input
    }
    
    func getContextName() -> String {
        guard let contextId = input.contextId else { return "" }
        return dataManager.context(id: contextId)?.name ?? ""
    }
}
