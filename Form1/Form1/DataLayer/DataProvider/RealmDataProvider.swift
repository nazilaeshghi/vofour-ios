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
    
    func addTast() {
    }
    
    func fetchTasks() -> [TaskDataModel] {
        return []
    }
    
    func fetchContexts() -> [Context] {
        do {
          return try realm().objects(ContextRealm.self).detached
        } catch let error as NSError {
            ErrorLogger.log(domain: .dataBase, message: "Fetching Contexts faild, Something went wrong with Realm: \(error.localizedDescription)")
          return []
        }
    }
}


protocol DetachableObject: AnyObject {
  func detached() -> Self
}

extension Object: DetachableObject {
  func detached() -> Self {
    let detached = type(of: self).init()
    for property in objectSchema.properties {
      guard let value = value(forKey: property.name) else {
        continue
      }
      if let detachable = value as? DetachableObject {
        detached.setValue(detachable.detached(), forKey: property.name)
      } else { // Then it is a primitive
        detached.setValue(value, forKey: property.name)
      }
    }
    return detached
  }
}

extension List: DetachableObject {
  func detached() -> List<Element> {
    let result = List<Element>()
    forEach {
      if let detachableObject = $0 as? DetachableObject,
        let element = detachableObject.detached() as? Element {
        result.append(element)
      } else { // Then it is a primitive
        result.append($0)
      }
    }
    return result
  }
}

public extension Sequence where Iterator.Element: Object {

  var detached: [Element] {
        return self.map({ $0.detached() })
    }
  

}

public extension Sequence where Iterator.Element: Object {
  
}
