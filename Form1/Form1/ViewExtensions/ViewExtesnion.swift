//
//  ViewExtesnion.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/29/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
    
    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }
}
