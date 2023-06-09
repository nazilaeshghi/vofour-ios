//
//  SelectContextMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct SelectContextCellMockGenerator {
    
    static var item: ContextItemDisplayModel {
        return ContextItemDisplayModel(title: LabelDisplayModel(plainText: "خود شخصی (۲)",
                                                                style: .regularSubtitle),
                                       imageName: "Users_Context", contextID: "mockId", isSelected: true)
    }
    
    static var context: TaskContext {
        return DecodableContext(id: "iuytdrthhgjh", name: "خود شخصی", iconName: "context_self_knowledge")
    }
    
    static var contexts: [TaskContext] {
        return [
            SelectContextCellMockGenerator.context,
            SelectContextCellMockGenerator.context,
            SelectContextCellMockGenerator.context
        ]
    }
    
    static var items: [ContextItemDisplayModel] {
        return [SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item,
                SelectContextCellMockGenerator.item]
    }
}

struct SelectContextDataManagableMock: SelectContextDataManagable {
    var dataManager: DataManager = DataManager(dataProvider: MockDataProvider())
    
    func resetDataEntry() {
    }
    
    var selectedId: String?
    
    func fetchListOfContexts(type: ContextFilterType) -> [ContextListModel] {
        return SelectContextCellMockGenerator.contexts.map{ ContextListModel(context: $0, taskCount: 0)}
    }
    
    func filterContext(text: String, type: ContextFilterType, forceUpdate: Bool) -> [ContextListModel] { return  [] }
    func selectContext(contextID: String) {}
    func fetchTaskCount(for contextId: String) -> Int { return 0 }
}

