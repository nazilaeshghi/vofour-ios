//
//  NewGoalViewModel.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-06.
//  Copyright © 2023 Vofour. All rights reserved.
//

import Foundation

class NewGoalViewModel: ObservableObject {
    let dataManger: CreateeGoalDataManagable
    
    init(dataManger: CreateeGoalDataManagable) {
        self.dataManger = dataManger
    }
    
    func createGoal(title: String) -> Bool {
        guard dataManger.findGoal(title: title) != nil else {
            let _ = dataManger.createGoal(title: title)
            return true
        }
        return false
    }
}
