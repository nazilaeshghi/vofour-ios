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
    @State private var showingTaskCreationSheet = false
    @State private var taskID: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                DeviderView()
                VerticalSpaceView(space: .header)
                
                if $viewModel.didFetchDate.wrappedValue {
                    GeometryReader { geometry in
                        VStack(spacing: PublicTheme.vSpace2) {
                           
                            ScrollView {
                                // Date
                                Text(DateHelper().getFullDatestring(from: viewModel.currentDate))
                                    .applyStyle(style: .mediumTitle)
                                    .isHidden(!viewModel.isDayMode)
                                
                                // Progress view
                                ZStack {
                                    CircularProgressView(progress: $viewModel.item.progress.wrappedValue ,
                                                         color: $viewModel.item.color.wrappedValue,
                                                         lineWidth: 16)
                                    
                                    TaskDetailsOperandView(increment: increment,
                                                           decrement: decrement,
                                                           countLabel: viewModel.item.count,
                                                           totalLabel: viewModel.item.subtitle)
                                }
                                .isHidden(!viewModel.isDayMode)
                                .frame(width: geometry.size.width * 0.5, height: geometry.size.width * 0.5)
                                
                                // Details
                                VStack(spacing: PublicTheme.collectionSpace) {
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.taskTypeTitle,
                                                       value: viewModel.activityType)
                                    
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.contextTitle,
                                                       value: viewModel.contextName)
                                    
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.goalTitle,
                                                       value: viewModel.goalName)
                                    
                                    TaskDetailsRowView(title: LocalizedString.Input.startDateSelectoreTitle,
                                                       value: viewModel.startDate ?? "")
                                    .isHidden(viewModel.hideStartDate())
                                    
                                    TaskDetailsRowView(title: LocalizedString.Input.endDateSelectoreTitle,
                                                       value: viewModel.endDate ?? "")
                                    .isHidden(viewModel.hideEndDate())
                                    
                                    TaskDetailsRowView(title: LocalizedString.Input.durationSelectoreTitle,
                                                       value: viewModel.duration ?? "")
                                    .isHidden(viewModel.hideDuration())
                                    
                                    TaskDetailsRowView(title: LocalizedString.TaskDetail.weekDaysTitle,
                                                       value: viewModel.weekDays ?? "")
                                    .isHidden(viewModel.hideWeekDays())
                                    
                                    TaskDetailsRowView(title: viewModel.repeatTitleStr,
                                                       value: viewModel.numberOfRepeat ?? "")
                                    .isHidden(viewModel.hideNumberOfRepeat())                                    
                                                                        
                                    VStack(alignment: .leading, spacing: PublicTheme.collectionSpace) {
                                        TaskDetailsDoubleRowView(title: LocalizedString.Input.obstacleHeader,
                                                           value: viewModel.prevent ?? "")
                                        .isHidden(viewModel.hidePrevent())
                                        
                                        TaskDetailsDoubleRowView(title: LocalizedString.Input.reasonTitle,
                                                           value: viewModel.reason ?? "")
                                        .isHidden(viewModel.hideReason())
                                        
                                        TaskDetailsDoubleRowView(title: LocalizedString.TaskDetail.for100,
                                                           value: viewModel.for100 ?? "")
                                        .isHidden(viewModel.hideFor100())
                                    }
                                }
                                .applyBasicViewStyle()

                                Spacer()
                            }
                            
                            TwoButtonsView(primaryButtonText: LocalizedString.TaskDetail.editButton,
                                           secondaryButtonText: LocalizedString.TaskDetail.deleteButton,
                                           primaryAction: editAction,
                                           secondaryAction: deleteAction,
                                           destructive: true)
                            .applyBasicViewStyle()
                        }
                    }
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
            .sheet(item: $taskID, onDismiss: {
                showingTaskCreationSheet = false
                taskID = nil
            }, content: {  taskId in
                AppCoordinator.shared.makeEditTaskCreationStep1View(taskId: taskId)
                    .environment(\.layoutDirection, .rightToLeft)
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
        taskID = viewModel.item.id
        showingTaskCreationSheet = true
    }
}

struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailView(viewModel: TaskDetailViewModel(dataManager: TaskDetailDataMock(), currentDate: Date()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 6S"))
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
