//
//  TodayCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TodayCoordinator: Coordinator {
    static var destinationIdentifier: DestinationIdentifier = TodayDestinationContext().destinationIdentifier
    
    private var context: TodayDestinationContext?
    private var viewModel: TodayViewModel!
    
    var destinationView: TodayView {
        return TodayView(viewModel: viewModel)
    }
    
    required init?(context: DestinationContext) {
        guard let context = context as? TodayDestinationContext else { return nil }
        self.context = context
        let dataManager = TodayDataManager()
        self.viewModel = TodayViewModel(dataManager: dataManager)
    }
    
    func start(options: PresentationOptions) -> Presentation {
        .nothing
    }
}
