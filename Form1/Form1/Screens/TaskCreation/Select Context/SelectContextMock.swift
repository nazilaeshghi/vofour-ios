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
                                                                style: .smallTitleStyle),
                                       imageName: "Users_Context", contextID: "mockId")
    }
    
    static var context: Context {
        return DecodableContext(id: "iuytdrthhgjh", name: "خود شخصی", iconName: "context_self")
    }
    
    static var contexts: [Context] {
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
    func fetchListOfContexts() -> [Context] {
        return SelectContextCellMockGenerator.contexts
    }
    
    func filterContext(text: String) -> [Context] { return  [] }
}

