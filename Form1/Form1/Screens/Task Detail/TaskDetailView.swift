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
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                DeviderView()
                VerticalSpaceView(space: .header)
                
                if $viewModel.didFetchDate.wrappedValue {
                    GeometryReader { geometry in
                        VStack(spacing: PublicTheme.vSpace2) {
                            
                            // Date
                            Text(DateHelper().getFullDatestring(from: viewModel.currentDate))
                                .applyStyle(style: .mediumTitle)
                            
                            // Progress view
                            ZStack {
                                CircularProgressView(progress: $viewModel.item.progress.wrappedValue ,
                                                     color: $viewModel.item.background.wrappedValue)
                                
                                TaskDetailsOperandView(increment: increment,
                                                       decrement: decrement,
                                                       countLabel: viewModel.item.count,
                                                       totalLabel: viewModel.item.subtitle)
                            }
                            .frame(width: geometry.size.width * 0.7, height: geometry.size.width * 0.7)
                            
                            // Details
                            VStack(spacing: PublicTheme.collectionSpace) {
                                TaskDetailsRowView(title: LocalizedString.TaskDetail.taskTypeTitle,
                                                   value: viewModel.activityType)
                                TaskDetailsRowView(title: LocalizedString.TaskDetail.contextTitle,
                                                   value: viewModel.contextName)
                                TaskDetailsRowView(title: LocalizedString.TaskDetail.goalTitle,
                                                   value: viewModel.goalName)
                            }
                            
                            Spacer()
                            
                            TwoButtonsView(primaryButtonText: LocalizedString.TaskDetail.editButton,
                                           secondaryButtonText: LocalizedString.TaskDetail.deleteButton,
                                           primaryAction: editAction,
                                           secondaryAction: deleteAction,
                                           destructive: true)
                        }
                    }
                    .applyBasicViewStyle()
                }
            }
            .applyBackgroundColor()
            .onAppear(perform: refreshData)
            .applyToolbarBackStyle(with: viewModel.item?.title.plainText ?? "",
                                   backAction: dismiss)
            .onReceive(NotificationCenter.default.publisher(for: .dataChange)) { _ in refreshData() }
            .alert(isPresented: $showDeleteAlert, content: {
                Alert(
                    title: Text(LocalizedString.TaskDetail.deleteAlertTitle),
                    message: Text(LocalizedString.TaskDetail.deletealertSubtitle),
                    primaryButton:
                            .default(Text(LocalizedString.TaskDetail.cancel), action: {
                                showDeleteAlert = false
                            }),
                    secondaryButton:
                            .destructive(Text(LocalizedString.TaskDetail.deleteButton), action: {
                                viewModel.deleteTask()
                                dismiss()
                            })
                )
            })
        }
        .navigationBarHidden(true)
    }
    
    func decrement() {
        viewModel.decrement()
    }
    
    func increment() {
        viewModel.increment()
    }
    
    func refreshData() {
        viewModel.fetchDetails()
    }
    
    func deleteAction() {
        showDeleteAlert = true
    }
    
    func editAction() {
        
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskDetailViewModel(dataManager: TaskDetailDataMock(), currentDate: Date()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            .previewInterfaceOrientation(.portraitUpsideDown)
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

struct TaskDetailsOperandView: View {
    let increment: () -> Void
    let decrement: () -> Void
    
    let countLabel: LabelDisplayModel
    let totalLabel: LabelDisplayModel
    
    var body: some View {
        HStack {
            Button(action: increment, label: { Image.plus })
                .frame(width: 50, height: 50)
            
            VStack {
                TextView(model: countLabel)
                TextView(model: totalLabel)
            }
            
            Button(action: decrement, label: { Image.minus })
                .frame(width: 50, height: 50)
        }
    }
}
