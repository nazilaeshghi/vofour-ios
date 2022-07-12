//
//  SelectContextDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol SelectContextDataManagable {
    func fetchListOfContexts() -> [Context]
    func filterContext(text: String) -> [Context]
    func selectContext(contextID: String)
}

class SelectContextDataManager: SelectContextDataManagable {
    private let dataManager: DataManager
    private var cacheContexts: [Context] = []
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func fetchListOfContexts() -> [Context]  {
        cacheContexts = dataManager.fetchContexts()
        return cacheContexts
    }
    
    func filterContext(text: String) -> [Context] {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return cacheContexts
        }
        return cacheContexts.filter { $0.name.contains(text) }
    }
    
    func selectContext(contextID: String) {
        dataManager.currentInputEntry.updateContextId(id: contextID)
    }
}
