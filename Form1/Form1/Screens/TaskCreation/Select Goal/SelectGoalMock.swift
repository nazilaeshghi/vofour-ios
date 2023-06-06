//
//  SelectGoalMock.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct SelectGoalCellMockGenerator {
    static var item: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "مسابقات معماری (۳ فعالیت)",
                                            style: .regularSubtitle)
        return SelectGoalDisplayModel(id: "1",
                                      title: titleModel,
                                      selected: true)
    }
    
    static var unselectedItem: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "مسابقات معماری (۳ فعالیت)",
                                            style: .regularSubtitle)
        return SelectGoalDisplayModel(id: "2",
                                      title: titleModel,
                                      selected: false)
    }
    
    static var defaultItem: SelectGoalDisplayModel {
        let titleModel = LabelDisplayModel(plainText: "هدف ندارد و مستقل است (۲ فعالیت)",
                                            style: .regularSubtitle)
        return SelectGoalDisplayModel(id: "-1",
                                      title: titleModel,
                                      selected: false)
    }
    
    static var items: [SelectGoalDisplayModel] {
        return [SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.unselectedItem,
                SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.item,
                SelectGoalCellMockGenerator.item]
    }
    
    static var goals: [Goal] {
        return [ GoalEntity(id: "-1", title: "هدف ندارد و مستقل است (۲ فعالیت)"),
                 GoalEntity(id: "1", title: "مسابقات معماری (۳ فعالیت)"),
                 GoalEntity(id: "2", title: "مسابقات دومیدانی (۳ فعالیت)")
        ]
    }
}

class SelectGoalDataManagableMock: SelectGoalDataManagable {
    func selectGoal(with id: String) {}
    
    func fetchListOfGoals() -> [Goal] {
        return SelectGoalCellMockGenerator.goals
    }
    
    func createGoal(title: String) {}
    
    func findGoal(with id: String) -> Goal? {
       return nil
    }
    
    func findGoal(title: String) -> Goal? {
       return nil
    }
    
    var selectedGoalId: String? = nil
}
