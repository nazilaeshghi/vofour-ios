//
//  GoalRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-11.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift

@objcMembers class GoalRealm : Object, Goal {
    
    dynamic var id: String = "-"
    dynamic var title: String = "-"
    
    convenience init(goal: Goal) {
        self.init()
        self.id = goal.id
        self.title = goal.title
    }
}
