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
    
    var body: some View {
        List(viewModel.cards, id: \.id) { item in
            CardUIView(viewModel: item)
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
        .background(PublicTheme.background)
        .listStyle(PlainListStyle())
        .onAppear(perform: {
            viewModel.getTasks(date: Date())
            UIScrollView.appearance().keyboardDismissMode = .onDrag
        })
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TaskListView(viewModel: TaskListViewModel(dataManager: dataManager))
    }
}
