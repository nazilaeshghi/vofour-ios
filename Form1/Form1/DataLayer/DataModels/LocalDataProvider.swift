//
//  LocalDataProvider.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-19.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class LocalDataProvider {
    
    private var plistURL: URL? {
        return Bundle.main.url(forResource: "ContestsList", withExtension: "plist")
    }
    
    func fetchContexts() -> [DecodableContext]? {
        let decoder = PropertyListDecoder()
        
        guard let plistURL = plistURL else {
            ErrorLogger.log(domain: .decode, message: "plist url is wrong")
            return nil
        }
        
        guard let data = try? Data.init(contentsOf: plistURL) else {
            ErrorLogger.log(domain: .decode, message: "plist endoding to data faild")
            return nil
        }
        
        guard let contexts = try? decoder.decode([DecodableContext].self, from: data) else {
            ErrorLogger.log(domain: .decode, message: "decoding DecodableContext failed")
            return nil
        }
        return contexts
    }
}


struct DecodableContext: Decodable, TaskContext {
    let id: String
    let name: String
    let iconName: String
}
