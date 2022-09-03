//
//  SelectContextViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class SelectContextViewModel: ObservableObject {
    
    private let dataManager: SelectContextDataManagable
    
    init(dataManager: SelectContextDataManagable) {
        self.dataManager = dataManager
        fetchContexts()
    }
    
    @Published var items = [ContextItemDisplayModel]()
    
    func fetchContexts() {
        items = dataManager.fetchListOfContexts().map(transformContext)
    }
    
    private func transformContext(context: TaskContext) -> ContextItemDisplayModel {
        let taskCount = dataManager.fetchTaskCount(for: context.id)
        let title = taskCount > 0 ? ("\(context.name)" + " " + "(" + "\(taskCount)" + ")") : context.name
        let labelDisplayModel = LabelDisplayModel(plainText: title.convertToPersian(), style: .regularSubtitle)
        let imageName = context.iconName
        return ContextItemDisplayModel(title: labelDisplayModel,
                                       imageName: imageName,
                                       contextID: context.id,
                                       isSelected: context.id == (dataManager.selectedId ?? "")
        )
    }
    
    func filterContextas(with text: String) {
        items = dataManager.filterContext(text: text).map(transformContext)
    }
    
    func selectContext(id: String) {
        dataManager.selectContext(contextID: id)
        fetchContexts()
    }
    
    func reset() {
        dataManager.resetDataEntry()
    }
}
