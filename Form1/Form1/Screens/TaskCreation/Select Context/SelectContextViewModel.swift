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
    
    @Published var items =  [ContextItemDisplayModel]()
    
    func fetchContexts() {
        items = dataManager.fetchListOfContexts().map(transformContext)
    }
    
    private func transformContext(context: Context) -> ContextItemDisplayModel {
        let labelDisplayModel = LabelDisplayModel(plainText: context.name, style: .smallTitleStyle)
        let imageName = context.iconName
        return ContextItemDisplayModel(title: labelDisplayModel,
                                       imageName: imageName,
                                       contextID: context.id)
    }
    
    func filterContextas(with text: String) {
        items = dataManager.filterContext(text: text).map(transformContext)
    }
}
