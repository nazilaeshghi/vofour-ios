//
//  TaskDetailView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-01.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    @StateObject var viewModel: TaskDetailViewModel

    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Text(viewModel.item?.title.plainText ?? "")
                        .applyStyle(style: viewModel.item?.title.labelStyle ?? .bigNumberStyle)
                    Divider()
                }
                
            }
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            
            if let item = viewModel.item {
                GeometryReader { geometry in
                    ZStack {
                        CircularProgressView(progress: item.progress ,
                                             color: item.background)
                            .padding(.trailing, 40)
                            .padding(.leading, 40)

                        HStack {
                            Button(action: {
                                viewModel.decrement()
                            }, label: {
                                Image.minus
                            })
                                .frame(width: 50, height: 50)
                                .padding(.trailing, 40)
                            
                            Text(item.count.plainText)
                                .applyStyle(style: .hugeTitleStyle)
                            
                            Button(action: {
                                viewModel.increment()
                            }, label: {
                                Image.plus
                            })
                                .frame(width: 50, height: 50)
                                .padding(.leading, 40)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    Spacer()
                }
            }
        }
        .onAppear(perform: {
            viewModel.fetchDetails()
        })
    }
}
