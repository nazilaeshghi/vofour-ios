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
        NavigationStack {
            VStack(spacing: .zero) {
                DeviderView()
                
                ScrollView {
                    Group {
                        VerticalSpaceView(space: .header)

                        TaskCreationHeader(title: LocalizedString.TaskCreationStep2.header,
                                           items: viewModel.repetitionSegmentItems(),
                                           selectedType: $viewModel.isRepeatable)
                        
                        VerticalSpaceView(space: .inlineForm)
                            
                        VStack(spacing: PublicTheme.vSpace) {
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
                        }
                        
                        VerticalSpaceView(space: .header)
                    }
                    .applyBasicViewStyle()
                }
               Spacer()
                
                TwoButtonsView(primaryButtonText: LocalizedString.Buttons.storeDataTitle,
                               secondaryButtonText: LocalizedString.Buttons.previousTitle,
                               primaryAction: saveAction,
                               secondaryAction: dismissAction,
                               destructive: false)
                    .applyBasicViewStyle()
                
            }
            .applyBackgroundColor()

            .sheet(isPresented: $startDateCalendarPresented, content: {
                CalendarSheetView(presented: $startDateCalendarPresented,
                                  dateString: $viewModel.startDate,
                                  title: LocalizedString.Input.startDateSelectoreTitle,
                                  maxDate: viewModel.endDate)
            })
            .sheet(isPresented: $endDateCalendarPresented, content: {
                CalendarSheetView(presented: $endDateCalendarPresented,
                                  dateString: $viewModel.endDate,
                                  title: LocalizedString.Input.endDateSelectoreTitle,
                                  minDate: viewModel.startDate)
            })
            .sheet(isPresented: $durationPresented, content: {
                DurationSheetView(presented: $durationPresented,
                                  selectredDuration: $viewModel.selectedDuration)
                
            })
            .applyToolbarWithBackStyle(with: viewModel.header(), backAction: dismiss, closeAction: {
                NotificationCenter.default.post(name: .cloceClick,
                                                object: nil,
                                                userInfo: nil)
            })
        }
        .onAppear(perform: {
            viewModel.initBinders()
        })
    }
    
    func saveAction() {
        viewModel.saveTask()
        NotificationCenter.default.post(name: .cloceClick, object: nil)
        NotificationCenter.sendNotification(for: .dataChange)
    }
    
    func dismissAction() {
        dismiss()
    }
}

struct TaskCreationStep2View_Previews: PreviewProvider {
    static var previews: some View {
        TaskCreationStep2View(viewModel: TaskCreationStep2ViewModel(dataManager: TaskCreationStep2DataManagableMock(), editMode: false))
            .environment(\.layoutDirection, .rightToLeft)
            .previewDevice(PreviewDevice(rawValue: "iPhone 11 Pro"))
    }
}
