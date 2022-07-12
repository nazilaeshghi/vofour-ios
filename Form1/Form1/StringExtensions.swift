//
//  StringExtensions.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-12.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation


extension String {
  var isBlank: Bool {
    return allSatisfy({ $0.isWhitespace })
  }
}

extension Optional where Wrapped == String {
  var isBlank: Bool {
    return self?.isBlank ?? true
  }
}
