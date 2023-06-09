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

enum ContextFilterType: Int {
    case all = 0
    case active = 1
    case deactive = 2
}

protocol SelectContextDataManagable: BaseDataManagable {
    func fetchListOfContexts(type: ContextFilterType) -> [ContextListModel]
    func filterContext(text: String, type: ContextFilterType, forceUpdate: Bool) -> [ContextListModel]
    func selectContext(contextID: String)
    func fetchTaskCount(for contextId: String) -> Int
    var  selectedId: String? { get }
}

class SelectContextDataManager: SelectContextDataManagable {
    internal let dataManager: DataManager
    private var cacheContexts: [ContextListModel] = []
    private (set) var selectedId: String?
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
        selectedId = dataManager.currentInputEntry.contextId
    }
    
    private func fetchListOfContexts() {
        let contexts = dataManager.fetchContexts()
        cacheContexts  = contexts.map({ context in
            let count = fetchTaskCount(for: context.id)
            return ContextListModel(context: context, taskCount: count)
        })
    }
    
    func fetchListOfContexts(type: ContextFilterType) -> [ContextListModel]  {
        fetchListOfContexts()
        switch type {
        case .active:
            return cacheContexts.filter { $0.taskCount > 0 }
        case .deactive:
            return cacheContexts.filter { $0.taskCount == 0}
        case .all:
            return cacheContexts
        }
    }
    
    func filterContext(text: String, type: ContextFilterType, forceUpdate: Bool) -> [ContextListModel] {
        if forceUpdate {
            fetchListOfContexts()
        }
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            switch type {
            case .active:
                return cacheContexts.filter { $0.taskCount > 0 }
            case .deactive:
                return cacheContexts.filter { $0.taskCount == 0}
            case .all:
                return cacheContexts
            }
        }
        switch type {
        case .active:
            return cacheContexts.filter { $0.context.name.contains(text) && $0.taskCount > 0 }
        case .deactive:
            return cacheContexts.filter { $0.context.name.contains(text) && $0.taskCount == 0}
        case .all:
            return cacheContexts.filter { $0.context.name.contains(text) }
        }

    }
    
    func selectContext(contextID: String) {
        dataManager.currentInputEntry.updateContextId(id: contextID)
        selectedId = contextID
    }
    
    func fetchTaskCount(for contextId: String) -> Int {
        return dataManager.fetchTaskCount(for: contextId)
    }
}
