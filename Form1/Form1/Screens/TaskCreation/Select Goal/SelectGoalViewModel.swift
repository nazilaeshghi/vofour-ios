//
//  SelectGoalViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class SelectGoalViewModel: ObservableObject {
    
    private let dataManager: SelectGoalDataManagable
    
    @Published private(set) var items: [SelectGoalDisplayModel] = []
    @Published private(set) var defaultItem: SelectGoalDisplayModel
    
    init(dataManager: SelectGoalDataManagable) {
        self.dataManager = dataManager
        defaultItem = SelectGoalViewModel.getDefaultGoal()
        getGoals()
    }
    
    func getGoals() {
        let rawGoals = dataManager.fetchListOfGoals()
        let goalDisplayModels = rawGoals.map { goal -> SelectGoalDisplayModel in
            let titleModel = LabelDisplayModel(plainText: goal.title,
                                               style: .smallTitleStyle)
            return SelectGoalDisplayModel(id: goal.id,
                                          title: titleModel,
                                          selected: dataManager.selectedGoalId == goal.id ? true : false)
        }
        
        items = goalDisplayModels
    }
    
    private static func getDefaultGoal() -> SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: LocalizedString.SelectGoalPage.defaultGoalTitle,
                                           style: .smallTitleStyle)
        return SelectGoalDisplayModel(id: "-1",
                                      title: titleModel,
                                      selected: false)
    }
    
    func addGoal(title: String) {
        dataManager.createGoal(title: title)
        getGoals()
    }
    
    func selectGoal(goalID: String) {
        dataManager.selectGoal(with: goalID)
    }
}
