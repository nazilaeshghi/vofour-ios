//
//  TaskCreationStep2View.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-06-04.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

struct TaskCreationStep2View: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: TaskCreationStep2ViewModel
    
    @State private var startDateCalendarPresented = false
    @State private var endDateCalendarPresented = false
    @State private var durationPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                ScrollView {
                    VStack (spacing: 24) {
                        // Header section
                        TaskStepsHeader(title: LocalizedString.TaskCreationStep1.header)
                        
                        // Date Section
                        SegmentedPicker(items: viewModel.getTaskRepetitionSegmentItems(), selection: $viewModel.isRepeatable)
                        
                        // Content
                        switch (viewModel.isItCreation, viewModel.isRepeatable) {
                        case (true, 0):
                            TaskCreationViewNonRepeatitive(dateText: viewModel.startDate,
                                                           durationText: viewModel.selectedDuration?.amount.timeStr,
                                                           startDateCalendarPresented: $startDateCalendarPresented,
                                                           durationPresented: $durationPresented)
                        case (true, 1):
                            TaskCreationViewRepeatitive(repeatNum: $viewModel.repeatNum,
                                                        weekDays: $viewModel.weekDays,
                                                        startDateText: viewModel.startDate,
                                                        endDateText: viewModel.endDate,
                                                        durationText: viewModel.selectedDuration?.amount.timeStr,
                                                        startDateCalendarPresented: $startDateCalendarPresented,
                                                        endtDateCalendarPresented: $endDateCalendarPresented,
                                                        durationPresented: $durationPresented)
                        case (false, 0):
                            QuitEntirelyView(startDateText: viewModel.startDate,
                                             endDateText: viewModel.endDate,
                                             startDateCalendarPresented: $startDateCalendarPresented,
                                             endtDateCalendarPresented: $endDateCalendarPresented)
                        case (false, 1):
                            QuitWithLimitView(repeatNum: $viewModel.repeatNum,
                                              startDateText: viewModel.startDate,
                                              endDateText: viewModel.endDate,
                                              startDateCalendarPresented: $startDateCalendarPresented,
                                              endtDateCalendarPresented: $endDateCalendarPresented)
                            
                        default:
                            EmptyView()
                        }
        
                        // Reminder Section
                        ReminderView(needReminder: $viewModel.needReminder,
                                     reminders: $viewModel.reminders)

                        // Color Section
                        ColorSelectorView(selectedColor: $viewModel.selectedColor)
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    TwoButtonsView(primaryButtonText: LocalizedString.Buttons.storeDataTitle,
                                   secondaryButtonText: LocalizedString.Buttons.previousTitle, primaryAction: {
                        viewModel.saveTask()
                        NotificationCenter.default.post(name: .cloceClick, object: nil)
                        NotificationCenter.sendNotification(for: .dataChange)
                        
                    }, secondaryAction: {
                        dismiss()
                    })
                        .frame(height: 60)
                }
            }
            .sheet(isPresented: $startDateCalendarPresented, content: {
                CalendarSheetView(presented: $startDateCalendarPresented,
                                  dateString: $viewModel.startDate,
                                  title: LocalizedString.Input.startDateSelectoreTitle)
            })
            .sheet(isPresented: $endDateCalendarPresented, content: {
                CalendarSheetView(presented: $endDateCalendarPresented,
                                  dateString: $viewModel.endDate,
                                  title: LocalizedString.Input.endDateSelectoreTitle)
            })
            .sheet(isPresented: $durationPresented, content: {
                DurationSheetView(presented: $durationPresented,
                                  selectredDuration: $viewModel.selectedDuration)
                
            })
            
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarWithBackStyle(with: viewModel.header(), backAction: dismiss, closeAction: {
                NotificationCenter.default.post(name: .cloceClick,
                                                object: nil,
                                                userInfo: nil)
            })

        }
        .onAppear(perform: {
            viewModel.initBinders()
        })
        .navigationBarHidden(true)
    }
    
}

struct TaskCreationStep2View_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationStep2View(viewModel: TaskCreationStep2ViewModel(dataManager: TaskCreationStep2DataManagableMock()))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
