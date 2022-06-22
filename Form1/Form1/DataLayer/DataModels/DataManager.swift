//
//  DataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class DataManager {
    private let dataProvider: DataProvider
    
    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func saveContexts() {
        dataProvider.saveContexts()
    }
    
    func fetchContexts() -> [Context] {
        return dataProvider.fetchContexts()
    }
    
    func context(id: String) -> Context? {
        return dataProvider.findContext(id: id)
    }
}
