//
//  TaskDetailCoordinator.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

class TaskDetailCoordinator: Coordinator {
    static var destinationIdentifier: DestinationIdentifier = TodayDestinationContext().destinationIdentifier
    
    private var context: TaskDetailContext?
    private var viewModel: TaskDetailViewModel!
    
    var destinationView: TaskDetailView {
        return TaskDetailView(viewModel: viewModel)
    }
    
    required init?(context: DestinationContext) {
        guard let context = context as? TaskDetailContext else { return nil }
        self.context = context
        let dataManager = TaskDetailDataManager()
        self.viewModel = TaskDetailViewModel(dataManager: dataManager)
    }
    
    func start(options: PresentationOptions) -> Presentation {
        .nothing
    }
}
