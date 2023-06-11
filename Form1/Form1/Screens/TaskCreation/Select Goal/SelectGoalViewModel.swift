//
//  SelectGoalViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct GoalSectionDisplayModel {
    let items: [SelectGoalDisplayModel]
    let isDefault: Bool
    let title: String
    let id: String
}

class SelectGoalViewModel: ObservableObject {
    private let dataManager: SelectGoalDataManagable
    @Published private(set) var items: [GoalSectionDisplayModel] = []
    
    init(dataManager: SelectGoalDataManagable) {
        self.dataManager = dataManager
        getGoals()
    }
    
    func getGoals() {
        
        var displayItems = [GoalSectionDisplayModel]()
        displayItems.append(makeFirstSection())
        
        let rawGoals = dataManager.fetchListOfGoals()

        let goalDisplayModels = rawGoals.compactMap { goal -> SelectGoalDisplayModel? in
            guard goal.id != "-1" else { return nil }
            let titleModel = LabelDisplayModel(plainText: goal.title,
                                               style: .regularSubtitle)
            return SelectGoalDisplayModel(id: goal.id,
                                          title: titleModel,
                                          selected: dataManager.selectedGoalId == goal.id ? true : false)
        }
        
        let secondSection = GoalSectionDisplayModel(items: goalDisplayModels,
                                                    isDefault: false,
                                                    title: LocalizedString.SelectGoalPage.sectionHeader,
                                                    id: UUID().uuidString)
        displayItems.append(secondSection)
        
        items = displayItems
    }
    
    func makeFirstSection() -> GoalSectionDisplayModel {
        let defaultTitleModel = LabelDisplayModel(plainText: LocalizedString.SelectGoalPage.defaultGoalTitle,
                                                  style: .regularSubtitle)
        let sectionTitle = LocalizedString.SelectGoalPage.defaultGoalSectionTitle
        let defaultItem = SelectGoalDisplayModel(id: "-1",
                                                 title: defaultTitleModel,
                                                 selected: dataManager.selectedGoalId == "-1" ? true : false)
        
        return GoalSectionDisplayModel(items: [defaultItem],
                                       isDefault: true,
                                       title: sectionTitle,
                                       id: UUID().uuidString)
    }
    
    func selectGoal(goalID: String) {
        dataManager.selectGoal(with: goalID)
    }
}
