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
    
    func addTask() {
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return []
    }
    
    // MARK: - Context
    func fetchContexts() -> [Context] {
        do {
            return try realm().objects(ContextRealm.self).detached
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Fetching Contexts faild, Something went wrong with Realm: \(error.localizedDescription)")
            return []
        }
    }
    
    func findContext(id: String) -> Context? {
        do {
            return try realm().objects(ContextRealm.self).where{ $0.id == id }.first
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding context faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
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
            return try realm().objects(GoalRealm.self).where{ $0.id == id }.first
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Finding Goal faild, Something went wrong with Realm: \(error.localizedDescription)")
            return nil
        }
    }
}
