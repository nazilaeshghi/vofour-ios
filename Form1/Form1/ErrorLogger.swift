//
//  ErrorLogger.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct ErrorLogger {
    static func log(domain: ErrorDomain, message: String) {
        #if DEBUG
        print ("\(domain.rawValue): \(message)")
        #endif
    }
}

enum ErrorDomain: String {
    case decode = "Decoding"
    case dataBase = "Database"
}
