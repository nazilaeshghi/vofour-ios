//
//  TodayViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TodayViewModel: ObservableObject {
    private let dataManager: TodayDataManagable
    
    init(dataManager: TodayDataManagable) {
        self.dataManager = dataManager
    }
    
    @Published var title: String = "This is Today"
    
    func changeTitle(to value: String) {
        self.title = value
    }
}
