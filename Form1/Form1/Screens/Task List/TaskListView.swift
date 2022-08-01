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
    let dateHelper = DateHelper()
    @State private var showingDetailSIsActive = false
    @State private var taskID: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $showingDetailSIsActive) {
                    AppCoordinator.shared.makeTaskDetailsView(taskId: taskID, selectedDate: selectedDate)
                } label: {
                    EmptyView()
                }.opacity(0)
                
                Spacer(minLength: 20)
                Text(dateHelper.getPersianRelativeDate(for: selectedDate))
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
                    })
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .onTapGesture {
                            taskID = item.wrappedValue.id
                            showingDetailSIsActive = true
                        }
                }
                .background(PublicTheme.background)
                .listStyle(PlainListStyle())
                .onAppear(perform: {
                    viewModel.getTasks(date: selectedDate)
                    UIScrollView.appearance().keyboardDismissMode = .onDrag
                })
                if viewModel.isEmptyForCurrentDate {
                    TaskListEmtyView()
                }
            }
            .background(PublicTheme.background)
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.dataChange)) { obj in
                viewModel.getTasks(date: selectedDate)
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
