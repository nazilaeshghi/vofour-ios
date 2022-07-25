//
//  TodayUIView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    
    @ObservedObject var viewModel: TodayViewModel
    
    var body: some View {
//        VStack {
            Text("viewModel.title")
//            Button {
//                viewModel.changeTitle(to: "yoooooo")
//            } label: {
//                Text("ChangeText")
//            }
//        }
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        let dataManager = MockTodayDataManagable()
        TodayView(viewModel: TodayViewModel(dataManager: dataManager))
    }
}

struct MockTodayDataManagable: TodayDataManagable {
    func fetchTasks(date: Date) -> [TaskDataModel] { return [] }
}
