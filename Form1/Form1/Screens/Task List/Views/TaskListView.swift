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
        NavigationStack {
            VStack {
                                
                // Week Header
                VerticalSpaceView(space: .header)
                TaskHeaderView(selectedDate: $selectedDate,
                               todayProgressString: viewModel.todayProgressString)
                VerticalSpaceView(space: .header)
                
                // Show empty state
                if viewModel.cards.isEmpty {
                    TaskListEmtyView()
                }
                else {
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
            }
            .sheet(item: $taskID) { taskId in
                AppCoordinator.shared.makeTaskDetailsView(taskId: taskId, selectedDate: selectedDate)
                    .environment(\.layoutDirection, .rightToLeft)
            }
            .gesture(DragGesture(minimumDistance: 10)
                        .onEnded({ value in
                if value.translation.width < 0 {
                    guard let nextDate = viewModel.nextDate(for: selectedDate) else { return }
                    selectedDate = nextDate
                }
                
                if value.translation.width > 0 {
                    guard let nextDate = viewModel.previousDate(for: selectedDate) else { return }
                    selectedDate = nextDate
                }
            }))
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}
