//
//  ContextRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift

@objcMembers class ContextRealm : Object, TaskContext {    
    dynamic var id: String = "-"
    dynamic var name: String = "-"
    dynamic var iconName: String = "-"
    
    convenience init(context: TaskContext) {
        self.init()
        self.id = context.id
        self.name = context.name
        self.iconName = context.iconName
    }
}
