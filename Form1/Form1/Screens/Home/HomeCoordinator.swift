//
//  HomeCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class HomeCoordinator: Coordinator {
    static var destinationIdentifier: DestinationIdentifier = HomeDestinationContext().destinationIdentifier
    
    private var context: HomeDestinationContext!
    
    var destinationView: HomeView {
        return HomeView()
    }
    
    required init?(context: DestinationContext) {
        guard let context = context as? HomeDestinationContext else { return nil }
        self.context = context
    }
    
    func start(options: PresentationOptions) -> Presentation {
        .nothing
    }
}


