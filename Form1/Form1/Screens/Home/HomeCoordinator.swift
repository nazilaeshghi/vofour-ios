//
//  HomeCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/5/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class HomeCoordinator {
    static var destinationIdentifier: DestinationIdentifier = HomeDestinationContext().destinationIdentifier
    
    private var context: HomeDestinationContext!
    
    var destinationView: HomeView {
        return HomeView()
    }
    
    required init(context: HomeDestinationContext) {
        self.context = context
    }
}


