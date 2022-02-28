//
//  TaskDetailContext.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct TaskDetailContext: DestinationContext {
    var destinationIdentifier: DestinationIdentifier { "TaskDetailContext" }
    var taskId: String
}
