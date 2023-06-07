//
//  IsVisible.swift
//  forMe From
//
//  Created by Hosseini Zadeh, Morteza on 2023-06-07.
//  Copyright © 2023 Vofour. All rights reserved.
//

import SwiftUI

extension View {
    
    func isVisible(_ visible: Bool) -> some View {
        modifier(
            IsHidden(visible: visible))
    }
}

struct IsHidden: ViewModifier {
    var visible: Bool
    
    func body(content: Content) -> some View {
        if visible {
            content
        }
    }
}
