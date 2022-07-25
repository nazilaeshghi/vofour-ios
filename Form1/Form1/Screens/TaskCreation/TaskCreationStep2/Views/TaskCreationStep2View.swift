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
                        SegmentedPicker(items: viewModel.getSegmentItems(), selection: $viewModel.isRepeatable)
                        
                        if viewModel.isItActivity {
                            if viewModel.isRepeatable == 0  {
                                TaskCreationViewNonRepeatitive(dateText: viewModel.startDate,
                                                               durationText: viewModel.selectedDuration?.amount.timeStr,
                                                               startDateCalendarPresented: $startDateCalendarPresented,
                                                               durationPresented: $durationPresented)
                            }
                            else {
                                TaskCreationViewRepeatitive(repeatNum: $viewModel.repeatNum,
                                                            weekDays: $viewModel.weekDays,
                                                            startDateText: viewModel.startDate,
                                                            endDateText: viewModel.endDate,
                                                            durationText: viewModel.selectedDuration?.amount.timeStr,
                                                            startDateCalendarPresented: $startDateCalendarPresented,
                                                            endtDateCalendarPresented: $endDateCalendarPresented,
                                                            durationPresented: $durationPresented)
                            }
                        }
                        else {
                            if viewModel.isRepeatable == 0  {
                                QuitEntirelyView(startDateText: viewModel.startDate,
                                                 endDateText: viewModel.endDate,
                                                 startDateCalendarPresented: $startDateCalendarPresented,
                                                 endtDateCalendarPresented: $endDateCalendarPresented)
                            }
                            else {
                                QuitWithLimitView(repeatNum: $viewModel.repeatNum,
                                                  startDateText: viewModel.startDate,
                                                  endDateText: viewModel.endDate,
                                                  startDateCalendarPresented: $startDateCalendarPresented,
                                                  endtDateCalendarPresented: $endDateCalendarPresented)
                            }
                        }
                        
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
                        NotificationCenter.default.post(name: NSNotification.cloceClick,
                                                        object: nil,
                                                        userInfo: nil)
                        
                    }, secondaryAction: {
                        dismiss()
                    })
                        .frame(height: 60)
                }
            }
            .sheet(isPresented: $startDateCalendarPresented) {
                
            } content: {
                CalendarSheetView(presented: $startDateCalendarPresented,
                                  dateString: $viewModel.startDate,
                                  title: LocalizedString.Input.startDateSelectoreTitle)
            }
            
            .sheet(isPresented: $endDateCalendarPresented) {
            } content: {
                CalendarSheetView(presented: $endDateCalendarPresented,
                                  dateString: $viewModel.endDate,
                                  title: LocalizedString.Input.endDateSelectoreTitle)
            }
            
            .sheet(isPresented: $durationPresented) {
            } content: {
                DurationSheetView(presented: $durationPresented,
                                  selectredDuration: $viewModel.selectedDuration)
                
            }
            
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarWithBackStyle(with: viewModel.header(), backAction: dismiss, closeAction: {
                NotificationCenter.default.post(name: NSNotification.cloceClick,
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

struct TaskCreationViewNonRepeatitive: View {
    var dateText: String?
    var durationText: String?
    @Binding var startDateCalendarPresented: Bool
    @Binding var durationPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
            SelectorInoutCell(text: dateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.dateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: durationText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
                }
        }
    }
}

struct QuitEntirelyView: View {
    var startDateText: String?
    var endDateText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
            SelectorInoutCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
        }
    }
}

struct TaskCreationViewRepeatitive: View {
    @Binding var repeatNum: Int
    @Binding var weekDays: [WeekDayObject]
    
    var startDateText: String?
    var endDateText: String?
    var durationText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    @Binding var durationPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
            SelectorInoutCell(text: durationText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
                }
            
            SelectorInoutCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
            RepeatView(weekDays: $weekDays, repeatNum: $repeatNum)
        }
    }
}

struct QuitWithLimitView: View {
    @Binding var repeatNum: Int
    var startDateText: String?
    var endDateText: String?
    
    @Binding var startDateCalendarPresented: Bool
    @Binding var endtDateCalendarPresented: Bool
    
    var body: some View {
        VStack (spacing: 24) {
            SelectorInoutCell(text: startDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: endDateText.convertToPersian(),
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
            
            ChangeRepeatView(repeatNum: $repeatNum, title: LocalizedString.QuitHabitStep2.numberOfRepeatTitle)
        }
    }
}

struct TaskStepsHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .applyStyle(style: LabelStyle.tableHeaderStyle)
            Spacer()
        }
    }
}

