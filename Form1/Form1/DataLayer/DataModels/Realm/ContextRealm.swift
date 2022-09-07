//
//  ContextRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import RealmSwift

class ContextRealm : Object, TaskContext {
    @Persisted (primaryKey: true) var id: String = "-"
    @Persisted var name: String = "-"
    @Persisted var iconName: String = "-"
    
    convenience init(context: TaskContext) {
        self.init()
        self.id = context.id
        self.name = context.name
        self.iconName = context.iconName
    }
}
