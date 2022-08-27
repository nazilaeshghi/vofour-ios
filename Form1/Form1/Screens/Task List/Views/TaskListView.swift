//
//  TaskListView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @StateObject var viewModel: TaskListViewModel
    @State private var selectedDate: Date = Date()
    @State private var showingDetailSIsActive = false
    @State private var taskID: String?
    
    let dateHelper = DateHelper()
    
    var body: some View {
        NavigationView {
            VStack {
                                
                // Week Header
                VerticalSpaceView(space: .header)
                TaskHeaderView(selectedDate: $selectedDate,
                               todayProgressString: viewModel.todayProgressString)
                VerticalSpaceView(space: .header)
                
                // Task List
                List($viewModel.cards, id: \.id) { item in
                    CardUIView(viewModel: item, increamentAction: {
                        viewModel.increamentTask(task: item.wrappedValue, date: selectedDate)
                        NotificationCenter.sendNotification(for: .dataChange)
                    }, detailAction: {
                        taskID = item.id
                        showingDetailSIsActive = true
                    })
                }
                .applyListBasicStyle()
                
                VerticalSpaceView(space: .header)
                
                // Show empty state
                if viewModel.cards.isEmpty {
                    TaskListEmtyView()
                }
            }
            .applyBasicViewStyle()
            .navigationBarHidden(true)
            .onAppear(perform: {
                viewModel.getTasks(date: selectedDate)
            })
            .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
                viewModel.getTasks(date: selectedDate)
                selectedDate = selectedDate
            }
            .onChange(of: selectedDate) { newValue in
                viewModel.getTasks(date: newValue)
                NotificationCenter.sendNotification(for: .dataChange)
            }
            .fullScreenCover(item: $taskID) {} content: { taskId in
                AppCoordinator.shared.makeTaskDetailsView(taskId: taskId, selectedDate: selectedDate)
            }
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}
