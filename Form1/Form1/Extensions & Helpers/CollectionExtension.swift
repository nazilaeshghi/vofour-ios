//
//  CollectionExtension.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-18.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

public extension Collection {
    /// Performs a range-safe subscript of the Collection, returned as an Optional.
    /// If the index is out of range or cannot be found, nil will be returned. For example:
    ///
    ///     let items = [0,1,2]
    ///     assert(items[safe: 1] == 1)
    ///     assert(items[safe: 3] == nil)
    ///
    ///    - Parameter index: the value used to index into the array
    ///
    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Array where Element == WeekDayObject {
    func getStringRepresentative() -> String {
        return self.filter{ $0.selected }.map{ $0.id }.joined(separator: ",")
    }
}

extension Array where Element == TimeObject {
    func getStringRepresentative() -> String {
        return self.map{ $0.representingString }.joined(separator: ", ")
    }
}
