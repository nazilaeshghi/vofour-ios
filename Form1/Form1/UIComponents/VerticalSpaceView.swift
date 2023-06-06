//
//  VerticalSpaceView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-23.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct VerticalSpaceView: View {
    let space: SpaceType
    var body: some View {
        Spacer().frame(height: space.value)
    }
}

enum SpaceType {
    case header
    case inlineForm
    case pageHeade
    case title
    
    var value: CGFloat {
        switch self {
        case .header:
            return PublicTheme.vHeaderSpace
        case .inlineForm:
            return PublicTheme.vSpace
        case .pageHeade:
            return PublicTheme.vSpace
        case .title:
            return PublicTheme.inputCellSpacing
        }
    }
}
