//
//  BindingExtension.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-10.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}
