//
//  CoordinatorRegistration.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/3/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import UIKit
import SwiftUI

protocol Coordinator {
    static var destinationIdentifier: DestinationIdentifier { get }
    init?(context: DestinationContext)
    func start(options: PresentationOptions) -> Presentation
}

class DefaultCoordinator {
    
    static var destinationIdentifier: DestinationIdentifier = "Default"
    private var context: DestinationContext?
    
    var destinationView: some View {
        return EmptyView()
    }
    
    required init?(context: DestinationContext) {
        self.context = context
    }
    
    func start(options: PresentationOptions) -> Presentation {
        .nothing
    }
    
}

protocol CoordinatorRegistration {
    var identifier: DestinationIdentifier { get }
    func construct(context: DestinationContext) -> DefaultCoordinator?
}

struct CoordinatorRegisterator<T: DefaultCoordinator>: CoordinatorRegistration {
    let identifier = T.destinationIdentifier
    
    init() {}
    
    func construct(context: DestinationContext) -> DefaultCoordinator? {
        return T(context: context)
    }
}



//class CoordinatorNavigation {
//    
//    internal var registrations: [DestinationIdentifier: CoordinatorRegistration] = [:]
//    
//    
//    func registerCoordinators() {
//        let destinationCoordinator = CoordinatorRegisterator<TaskDetailCoordinator>()
//        register(destinationCoordinator)
//    }
//    
//    
//    func register(_ registration: CoordinatorRegistration) {
//        registrations[registration.identifier] = registration
//    }
//    
//    func unregister(identifier: DestinationIdentifier) {
//        registrations[identifier] = nil
//    }
//    
//    func retriveCoordinator(context: DestinationContext) -> DefaultCoordinator? {
//        guard let item        = registrations[context.destinationIdentifier],
//              let coordinator = item.construct(context: context) else { return nil}
//        return coordinator
//        
//    }
//}
