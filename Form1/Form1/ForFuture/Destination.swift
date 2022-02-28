//
//  DestinationIdentifier.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/3/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol DestinationContext {
    var destinationIdentifier: DestinationIdentifier { get }
}

struct DestinationIdentifier: ExpressibleByStringLiteral, Hashable {
    let identifier: String

    init(_ identifier: String) {
        self.identifier = identifier
    }

    init(stringLiteral value: String) {
        self.identifier = value
    }
    
    public var hash: Int { return identifier.hash }
    
    public func isEqual(_ object: Any?) -> Bool {
        guard let rhs = object as? DestinationIdentifier else { return false }
        
        return self.identifier == rhs.identifier
    }

}
