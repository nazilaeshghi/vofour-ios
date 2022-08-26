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
                
                Group {
                    Text(DateHelper().getFullDatestring(from: viewModel.currentDate))
                        .applyStyle(style: .mediumHeaderStyle)
                    
                    if $viewModel.didFetchDate.wrappedValue {
                        GeometryReader { geometry in
                            VStack {
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
                                    }
                                }
                                .frame(width: geometry.size.width, height: geometry.size.width)
                                .offset(x: 0, y: -20)
                                
                                
                                VStack(spacing: PublicTheme.collectionSpace) {
                                    HStack {
                                        Text(LocalizedString.TaskDetail.taskTypeTitle)
                                        CustomLineShapeWithAlignment(stratPoint: .leading, endPoint: .trailing)
                                                        .stroke(style: StrokeStyle(lineWidth: 1.0, dash: [5]))
                                                        .frame(height: 1.0)
                                        Text(viewModel.activityType)
                                    }
                                    
                                    HStack {
                                        Text(LocalizedString.TaskDetail.contextTitle)
                                        CustomLineShapeWithAlignment(stratPoint: .leading, endPoint: .trailing)
                                                        .stroke(style: StrokeStyle(lineWidth: 1.0, dash: [5]))
                                                        .frame(height: 1.0)
                                        Text(viewModel.contextName)
                                    }
                                    
                                    HStack {
                                        Text(LocalizedString.TaskDetail.goalTitle)
                                        CustomLineShapeWithAlignment(stratPoint: .leading, endPoint: .trailing)
                                                        .stroke(style: StrokeStyle(lineWidth: 1.0, dash: [5]))
                                                        .frame(height: 1.0)
                                        Text(viewModel.goalName)
                                    }
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
