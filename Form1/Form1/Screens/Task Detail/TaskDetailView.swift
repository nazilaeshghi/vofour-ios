//
//  TaskDetailView.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-08-01.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskDetailViewModel

    var body: some View {
        
        NavigationView {
            VStack {
                Divider()
                Text(DateHelper().getFullDatestring(from: viewModel.currentDate))
                    .applyStyle(style: .mediumHeaderStyle)
                
                if viewModel.didFetchDate {
                    GeometryReader { geometry in
                        ZStack {
                            CircularProgressView(progress: $viewModel.item.progress.wrappedValue ,
                                                 color: $viewModel.item.background.wrappedValue)
                                .padding(.horizontal, 40)

                            HStack {
                                Button(action: {
                                    viewModel.decrement()
                                }, label: {
                                    Image.minus
                                })
                                    .frame(width: 50, height: 50)
                                    .padding(.trailing, 40)
                                
                                VStack {
                                    Text($viewModel.item.count.wrappedValue.plainText.convertToPersian())
                                        .applyStyle(style: .hugeTitleStyle)
                                    Text($viewModel.item.subtitle.wrappedValue.plainText.convertToPersian())
                                        .applyStyle(style: .lightHeaderStyle)
                                }
                                
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
                        .offset(x: 0, y: -20)
                        Spacer()
                    }
                }
            }
            .onAppear(perform: {
                viewModel.fetchDetails()
            })
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarBackStyle(with: viewModel.item?.title.plainText ?? "",
                                   backAction: dismiss)
        }
        .navigationBarHidden(true)
        
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskDetailViewModel(dataManager: TaskDetailDataMock(), currentDate: Date()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}


struct OnFirstAppearModifier: ViewModifier {
    let perform:() -> Void
    @State private var firstTime: Bool = true
    
    func body(content: Content) -> some View {
        content
            .onAppear{
                if firstTime{
                    firstTime = false
                    self.perform()
                }
            }
    }
}


extension View {
  func onFirstAppear( perform: @escaping () -> Void ) -> some View {
    return self.modifier(OnFirstAppearModifier(perform: perform))
  }
}
