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
    @StateObject var viewModel: TaskDetailViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                DeviderView()
                VerticalSpaceView(space: .header)

                Group {
                    if $viewModel.didFetchDate.wrappedValue {
                        GeometryReader { geometry in
                            VStack(spacing: 40) {
                                
                                Text(DateHelper().getFullDatestring(from: viewModel.currentDate))
                                    .applyStyle(style: .mediumTitle)
                                
                                // Progress view
                                ZStack {
                                    CircularProgressView(progress: $viewModel.item.progress.wrappedValue ,
                                                         color: $viewModel.item.background.wrappedValue)
                                    
                                    HStack {
                                        
                                        Button(action: increment, label: { Image.plus })
                                            .frame(width: 50, height: 50)
                                        
                                        VStack {
                                            TextView(model: viewModel.item.count)
                                            TextView(model: viewModel.item.subtitle)
                                        }
                                        
                                        Button(action: decrement, label: { Image.minus })
                                            .frame(width: 50, height: 50)
                                    }
                                }
                                .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                                
                                // Details
                                VStack(spacing: PublicTheme.collectionSpace) {
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.taskTypeTitle, value: viewModel.activityType)
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.contextTitle, value: viewModel.contextName)
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.goalTitle, value: viewModel.goalName)
                                }
                            }
                        }
                    }
                }
                .applyBasicViewStyle()
            }
            .applyBackgroundColor()
            .onAppear(perform: {
                viewModel.fetchDetails()
            })
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarBackStyle(with: viewModel.item?.title.plainText ?? "",
                                   backAction: dismiss)
            .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { obj in
                viewModel.fetchDetails()
            }
        }
        .navigationBarHidden(true)
    }
    
    func decrement() {
        viewModel.decrement()
    }
    
    func increment() {
        viewModel.increment()
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskDetailViewModel(dataManager: TaskDetailDataMock(), currentDate: Date()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}


struct CustomLineShapeWithAlignment: Shape {
    
    let stratPoint: Alignment
    let endPoint: Alignment
    
    init(stratPoint: Alignment, endPoint: Alignment) {
        self.stratPoint = stratPoint
        self.endPoint = endPoint
    }
    
    private func cgPointTranslator(alignment: Alignment, rect: CGRect) -> CGPoint {
        
        switch alignment {
        case .topLeading: return CGPoint(x: rect.minX, y: rect.minY)
        case .top: return CGPoint(x: rect.midX, y: rect.minY)
        case .topTrailing: return CGPoint(x: rect.maxX, y: rect.minY)
            
        case .leading: return CGPoint(x: rect.minX, y: rect.midY)
        case .center: return CGPoint(x: rect.midX, y: rect.midY)
        case .trailing: return CGPoint(x: rect.maxX, y: rect.midY)
            
        case .bottomLeading: return CGPoint(x: rect.minX, y: rect.maxY)
        case .bottom: return CGPoint(x: rect.midX, y: rect.maxY)
        case .bottomTrailing: return CGPoint(x: rect.maxX, y: rect.maxY)
        default: return CGPoint(x: rect.minX, y: rect.minY)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            
            path.move(to: cgPointTranslator(alignment: stratPoint, rect: rect))
            path.addLine(to: cgPointTranslator(alignment: endPoint, rect: rect))
            
        }
        
    }
    
}


struct TaskDetailsRowView: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .applyStyle(style: .mediumSubtitle)
                .layoutPriority(1)
            
            CustomLineShapeWithAlignment(stratPoint: .trailing, endPoint: .leading)
                .stroke(Color.primaryTextColor, style: StrokeStyle(lineWidth: 1.0, dash: [4]))
                .frame(height: 1.0)
                .frame(minWidth: 20)
            
            Text(value)
                .applyStyle(style: .regularSubtitle)
                .layoutPriority(1)
        }
    }
}
