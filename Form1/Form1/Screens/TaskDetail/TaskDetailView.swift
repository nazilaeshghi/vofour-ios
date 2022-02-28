//
//  TaskDetailView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2/9/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    
    @ObservedObject var viewModel: TaskDetailViewModel
    
    var body: some View {
        VStack {
            Text("This is task Detail")
        }
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTaskDetailDataManagable()
        TaskDetailView(viewModel: TaskDetailViewModel(dataManager: dataManager))
    }
}

struct MockTaskDetailDataManagable: TaskDetailDataManagable {
    
}
