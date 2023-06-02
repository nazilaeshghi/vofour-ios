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
    public var object: String?
    
    public init(title: String, index: Int, object: String? = nil) {
        self.title = title
        self.index = index
        self.object = object
    }
}
