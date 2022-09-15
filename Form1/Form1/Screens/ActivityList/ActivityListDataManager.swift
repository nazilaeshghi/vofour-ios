//
//  ActivityListDataManager.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-09-14.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol ActivityListDataManagable {
}

class ActivityListDataManager: ActivityListDataManagable {
    private let dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
}
