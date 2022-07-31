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
    @State private var selectedDate: Date = Date()
    let dateHelper = DateHelper()
    
    var body: some View {
        VStack {
            Spacer(minLength: 20)
            Text(dateHelper.getPersianRelativeDate(for: selectedDate))
                .applyStyle(style: .titleStyle)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            TaskHeaderView(selectedDate: $selectedDate)
                .onChange(of: selectedDate) { newValue in
                    viewModel.getTasks(date: newValue)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 10, trailing: 16))
            
            List($viewModel.cards, id: \.id) { item in
                CardUIView(viewModel: item,
                           increamentAction: {
                    viewModel.increamentTask(task: item.wrappedValue, date: selectedDate)
                    viewModel.getTasks(date: selectedDate)
                })
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            }
            .background(PublicTheme.background)
            .listStyle(PlainListStyle())
            .onAppear(perform: {
                viewModel.getTasks(date: selectedDate)
                UIScrollView.appearance().keyboardDismissMode = .onDrag
            })
        }
        .background(PublicTheme.background)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.saveClick)) { obj in
            viewModel.getTasks(date: selectedDate)
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.settingChange)) { obj in
            viewModel.getTasks(date: selectedDate)
        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}
