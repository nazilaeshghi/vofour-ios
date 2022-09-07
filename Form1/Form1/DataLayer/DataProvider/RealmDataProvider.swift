//
//  RealmDataProvider.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmError: Error {
    case faildToOpenRealm
}

extension RealmError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .faildToOpenRealm:
            return "Opening Realm data base has been failed"
        }
    }
}


class ReqalmDataProvider: DataProvider {
    
    /// Returns the realm instance
    func realm() throws -> Realm {
        do {
            return try Realm()
        } catch  {
            throw RealmError.faildToOpenRealm
        }
    }
    
    let localDataProvider = LocalDataProvider()
    
    func saveContexts() {
        guard
            let decodableContexts = localDataProvider.fetchContexts()
        else {
            ErrorLogger.log(domain: .dataBase, message: "Saving contexts faild, unable to fetch contexts from plist file")
            return
        }
        
        let contextRealmObjects = decodableContexts.map{ ContextRealm(context: $0) }
        
        do {
            let realm  = try self.realm()
            try realm.write {
                realm.delete(realm.objects(ContextRealm.self))
                realm.add(contextRealmObjects)
            }
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Saving Contexts faild, Something went wrong with Realm: \(error.localizedDescription)")
        }
        
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return []
    }
    
    // MARK: - Context
    func fetchContexts() -> [TaskContext] {
        do {
            return try realm().objects(ContextRealm.self).detached
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Fetching Contexts faild, Something went wrong with Realm: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchHomeContexts() -> [HomeContextDataModel] {
        do {
            let contexts = try realm().objects(ContextRealm.self).detached
            let homeContexts = try contexts.map { context ->  HomeContextDataModel in
                let activityCount = try realm().objects(TaskRealm.self).where {
                    $0.contextId == context.id
                }.count
               return HomeContextDataModel(context: context, activityCount: activityCount)
            }
            return homeContexts
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Fetching Home Contexts faild, Something went wrong with Realm: \(error.localizedDescription)")
            return []
        }
    }

    
    func findContext(id: String) -> TaskContext? {
        do {
            return try realm().objects(ContextRealm.self).where{ $0.id == id }.first?.detached()
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding context faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchTaskCount(for contextID: String) -> Int {
        do {
            return try realm().objects(TaskRealm.self).where{ $0.contextId == contextID }.detached.count
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return 0
        }
    }
    
    // MARK: - Goal
    func fetchGoals() -> [Goal] {
        do {
            return try realm().objects(GoalRealm.self).detached
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Fetching Goals faild, Something went wrong with Realm: \(error.localizedDescription)")
            return []
        }
    }
    
    func createGoal(newEntity: Goal) {
        let goalRealm = GoalRealm(goal: newEntity)
        
        do {
            let realm  = try self.realm()
            try realm.write {
                realm.add(goalRealm)
            }
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Saving Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
        }
    }
    
    func findGoal(with id: String) -> Goal? {
        do {
            return try realm().objects(GoalRealm.self).where{ $0.id == id }.first?.detached()
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    // MARK: - Task
    func saveTask(entry: DataEntryDataModel) {
        let taskRealm = TaskRealm(task: entry)
        
        do {
            let realm  = try self.realm()
            try realm.write {
                realm.add(taskRealm, update: .modified)
            }
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Saving Task faild, Something went wrong with Realm: \(error.localizedDescription)")
        }
    }
    
    func fetchTask(id: String) -> TaskDataModel? {
        do {
            return try realm().objects(TaskRealm.self).where{ $0.taskID == id }.first?.detached()
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    func fetchTasks(for weekDay: String, date: Date) -> [DailyTaskDataModel] {
        do {
            let tasks =  try realm().objects(TaskRealm.self).where {
                ($0.startDate == date && $0.isRepeatable == false) || // Activity
                ($0.startDate <= date && $0.endDate >= date && $0.isRepeatable == true && $0.weekDays.contains(weekDay)) || // Activity with repeat
                ($0.startDate <= date && $0.endDate >= date && $0.isActivity == false) // Quit
            }.detached
            let dayRecords = try tasks.map { task -> DailyTaskDataModel in
                let record = try realm().objects(RecordRealm.self).where {
                    $0.taskID == task.taskID && $0.date == date
                }.first?.detached()
                let dayRecord = DailyTaskDataModel(task: task, record: record)
                return dayRecord
            }
            return dayRecords
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteTask(id: String) {
        do {
            let realm  = try self.realm()
            let tasks = realm.objects(TaskRealm.self).where { $0.taskID == id }
            let records = realm.objects(RecordRealm.self).where { $0.taskID == id }
            try realm.write {
                realm.delete(tasks)
                realm.delete(records)
            }
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "deleting record, Something went wrong with Realm: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Record
    func saveRecord(record: Record) {
        let recordRealm = RecordRealm(record: record)
        
        do {
            let realm  = try self.realm()
            try realm.write {
                realm.add(recordRealm)
            }
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Saving Record faild, Something went wrong with Realm: \(error.localizedDescription)")
        }
    }
    
    func fetchRecord(taskID: String, date: Date) -> Record? {
        do {
            return try realm().objects(RecordRealm.self).where{ $0.taskID == taskID && $0.date == date }.first?.detached()
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateRecord(recordID: String, count: Int) {
        do {
            let realm  = try self.realm()

            if let record = realm.objects(RecordRealm.self).where({ $0.recordID == recordID }).first {
                try realm.write {
                    record.count = count
                }
            }
            
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "updating record, Something went wrong with Realm: \(error.localizedDescription)")
        }
    }
}
