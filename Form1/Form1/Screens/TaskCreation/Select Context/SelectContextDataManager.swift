//
//  SelectContextDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol SelectContextDataManagable {
    func fetchListOfContexts() -> [TaskContext]
    func filterContext(text: String) -> [TaskContext]
    func selectContext(contextID: String)
}

class SelectContextDataManager: SelectContextDataManagable {
    private let dataManager: DataManager
    private var cacheContexts: [TaskContext] = []
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchListOfContexts() -> [TaskContext]  {
        cacheContexts = dataManager.fetchContexts()
        return cacheContexts
    }
    
    func filterContext(text: String) -> [TaskContext] {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return cacheContexts
        }
        return cacheContexts.filter { $0.name.contains(text) }
    }
    
    func selectContext(contextID: String) {
        dataManager.currentInputEntry.updateContextId(id: contextID)
    }
}
