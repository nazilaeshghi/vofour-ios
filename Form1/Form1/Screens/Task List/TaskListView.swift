//
//  TaskListView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskListViewModel
    @State private var selectedDate: Date = Date().getSimpleDate() ?? Date()
    @State private var showingDetailSIsActive = false
    @State private var taskID: String?
    
    let dateHelper = DateHelper()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 20)
                Text(dateHelper.getHeaderDate(for: selectedDate))
                    .applyStyle(style: .titleStyle)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
                TaskHeaderView(selectedDate: $selectedDate)
                    .onChange(of: selectedDate) { newValue in
                        viewModel.getTasks(date: newValue)
                        NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
                
                List($viewModel.cards, id: \.id) { item in
                    CardUIView(viewModel: item,
                               increamentAction: {
                        viewModel.increamentTask(task: item.wrappedValue, date: selectedDate)
                        viewModel.getTasks(date: selectedDate)
                        NotificationCenter.default.post(name: NSNotification.dataChange, object: nil)
                    },
                               detailAction: {
                        taskID = item.id
                        showingDetailSIsActive = true
                    })
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .background(PublicTheme.background)
                .listStyle(PlainListStyle())
                
                if viewModel.cards.isEmpty {
                    TaskListEmtyView()
                }
            }
            .onAppear(perform: {
                viewModel.getTasks(date: selectedDate)
                UIScrollView.appearance().keyboardDismissMode = .onDrag
            })
            .background(PublicTheme.background)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.dataChange)) { obj in
                viewModel.getTasks(date: selectedDate)
                selectedDate = selectedDate
            }
            .sheet(item: $taskID) {
                
            } content: {  taskId in
                AppCoordinator.shared.makeTaskDetailsView(taskId: taskId, selectedDate: selectedDate)
            }
            .navigationBarHidden(true)
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}


struct TaskListEmtyView: View {
    var body: some View {
        VStack{
            Spacer()
            Text(LocalizedString.Home.empty)
                .applyStyle(style: .homeEmptyStyle)
                .multilineTextAlignment(.center)
            
            Text("👇")
                .font(.system(size: 38))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}
