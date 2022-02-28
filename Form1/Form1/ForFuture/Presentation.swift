//
//  Presentation.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/3/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import UIKit

protocol Presentable: AnyObject {}
extension UIWindow: Presentable {}
extension UIViewController: Presentable {}

enum Presentation {
    case nothing
    case push(_ presentable: Presentable, options: PresentationOptions)
    case modal(_ presentable: Presentable, options: PresentationOptions)
    case alert(_ presentable: Presentable, options: PresentationOptions)
}

enum PresentationOptions {
    
    case none
    case animated
    case completion(_ completion: ((_ success: Bool) -> Void)?, animated: Bool = true)

    public var isAnimated: Bool {
        switch self {
        case .none:
            return false
        case .animated:
            return true
        case .completion(_, let animated):
            return animated
        }
    }
}
