//
//  SelectContextViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI


class SelectContextViewModel: ObservableObject {
    
    private let dataManager: SelectContextDataManagable
    var tyep: ContextFilterType {
        return ContextFilterType(rawValue: selection) ?? .all
    }
    
    let segments = [LocalizedString.ContextPage.allContexts,
                    LocalizedString.ContextPage.activeContexts,
                    LocalizedString.ContextPage.notActiveContexts].enumerated().map { Segment(title: $0.element, index: $0.offset)}
    init(dataManager: SelectContextDataManagable) {
        self.dataManager = dataManager
        fetchContexts()
    }
    
    @Published var items = [ContextItemDisplayModel]()
    @Published var selection: Int = 0
    
    private func fetchContexts() {
        items = dataManager.fetchListOfContexts(type: tyep).map(transformContext)
    }
    
    private func transformContext(model: ContextListModel) -> ContextItemDisplayModel {
        let title = model.taskCount > 0 ? ("\(model.context.name)" + " " + "(" + "\(model.taskCount)" + ")") : model.context.name
        let labelDisplayModel = LabelDisplayModel(plainText: title.convertToPersian(), style: .regularSubtitle)
        let imageName = model.context.iconName
        return ContextItemDisplayModel(title: labelDisplayModel,
                                       imageName: imageName,
                                       contextID: model.context.id,
                                       isSelected: model.context.id == (dataManager.selectedId ?? "")
        )
    }
    
    func filterContextas(with text: String) {
        items = dataManager.filterContext(text: text, type: tyep).map(transformContext)
    }
    
    func selectContext(id: String) {
        dataManager.selectContext(contextID: id)
        fetchContexts()
    }
    
    func reset() {
        dataManager.resetDataEntry()
    }
    
    var selectedContextID: String {
        return dataManager.selectedId ?? ""
    }
}
