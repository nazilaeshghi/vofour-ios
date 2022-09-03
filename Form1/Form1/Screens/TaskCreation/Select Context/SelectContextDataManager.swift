//
//  SelectContextDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol BaseDataManagable {
    var dataManager: DataManager { get }
    func resetDataEntry()
}

extension BaseDataManagable {
    func resetDataEntry() {
        dataManager.resetDataEntry()
    }
}

protocol SelectContextDataManagable: BaseDataManagable {
    func fetchListOfContexts() -> [TaskContext]
    func filterContext(text: String) -> [TaskContext]
    func selectContext(contextID: String)
    func fetchTaskCount(for contextId: String) -> Int
    var selectedId: String? { get }
}

class SelectContextDataManager: SelectContextDataManagable {
    internal let dataManager: DataManager
    private var cacheContexts: [TaskContext] = []
    private (set) var selectedId: String?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        selectedId = dataManager.currentInputEntry.contextId
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
        selectedId = contextID
    }
    
    func fetchTaskCount(for contextId: String) -> Int {
        return dataManager.fetchTaskCount(for: contextId)
    }
}
