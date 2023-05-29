//
//  TaskListEmtyView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-20.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct DayTaskListEmtyView: View {
    var body: some View {
        VStack{
            Spacer()
            Text(LocalizedString.Home.empty)
                .applyStyle(style: .emptyRegularTitle)
                .multilineTextAlignment(.center)
            
            Text("👇")
                .font(.system(size: 38))
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct TaskListEmtyView_Previews: PreviewProvider {
    static var previews: some View {
        DayTaskListEmtyView()
    }
}
