//
//  DataProvider.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

protocol DataProvider {
    
    func addTast()
    func fetchTask()
}

class ReqalmDataProvider: DataProvider {
    func addTast() {
    }
    
    func fetchTask() {
    }
}
