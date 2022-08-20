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
                
                // Navigation Link
                NavigationLink(isActive: $showingDetailSIsActive) {
                    AppCoordinator.shared.makeTaskDetailsView(taskId: taskID ?? "", selectedDate: selectedDate)
                } label: { EmptyView() }.opacity(0)
                
                Spacer(minLength: 20)
                
                // Week Header
                TaskHeaderView(selectedDate: $selectedDate,
                               todayProgressString: viewModel.todayProgressString)
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
                
                // Task List
                List($viewModel.cards, id: \.id) { item in
                    CardUIView(viewModel: item, increamentAction: {
                        viewModel.increamentTask(task: item.wrappedValue, date: selectedDate)
                        NotificationCenter.sendNotification(for: .dataChange)
                    }, detailAction: {
                        taskID = item.id
                        showingDetailSIsActive = true
                    })
                        .applyBasicCellStyle()
                }
                .applyListBasicStyle()
                
                if viewModel.cards.isEmpty {
                    TaskListEmtyView()
                }
            }
            .navigationBarHidden(true)
            .background(PublicTheme.background)
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
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}
