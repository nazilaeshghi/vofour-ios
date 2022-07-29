//
//  RecordRealm.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-28.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import RealmSwift

class RecordRealm: Object, Record {
    @Persisted var recordID: String = ""
    @Persisted var taskID: String = ""
    @Persisted var date: Date = Date()
    @Persisted var count: Int = 0
    @Persisted var total: Int = 0

    convenience init(record: Record) {
        self.init()
        self.recordID = record.recordID
        self.taskID = record.taskID
        self.date = record.date
        self.count = record.count
        self.total = record.total
    }
    
    override class func primaryKey() -> String {
        return "recordID"
    }
}
