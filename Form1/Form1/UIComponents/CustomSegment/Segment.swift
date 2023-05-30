//
//  File.swift
//  
//
//  Created by Jason Loewy on 4/27/23.
//

import Foundation

public struct Segment {
    
    public let title: String
    public var index: Int
    public var object: Any?
    
    public init(title: String, index: Int, object: Any? = nil) {
        self.title = title
        self.index = index
        self.object = object
    }
}
