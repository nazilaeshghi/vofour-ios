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
    @State var calendarDate: Date = Date()

    
    private let segmentItems = [
        LocalizedString.TaskCreationStep2.nonRepeatitiveActivity,
        LocalizedString.TaskCreationStep2.repeatitiveActivity
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Divider()
                ScrollView {
                    VStack (spacing: 24) {
                        // Header section
                        TaskStepsHeader(title: LocalizedString.TaskCreationStep1.header)
                        
                        // Date Section
                        SegmentedPicker(items: segmentItems, selection: $viewModel.isRepeatable)
                        
                        if viewModel.isRepeatable == 0  {
                            TaskCreationViewNonRepeatitive(dateText: viewModel.startDate,
                                                           durationText: viewModel.durationStr,
                                                           startDateCalendarPresented: $startDateCalendarPresented,
                                                           durationPresented: $durationPresented)
                        }
                        else {
                            TaskCreationViewRepeatitive(repeatNum: $viewModel.repeatNum,
                                                        weekDays: $viewModel.weekDays,
                                                        startDateText: viewModel.startDate,
                                                        endDateText: viewModel.endDate,
                                                        durationText: viewModel.durationStr,
                                                        startDateCalendarPresented: $startDateCalendarPresented,
                                                        endtDateCalendarPresented: $endDateCalendarPresented,
                                                        durationPresented: $durationPresented)
                        }
                        
                        // Color Section
                        ColorSelectorView(selectedColor: $viewModel.selectedColor)
                        Spacer()
                    }
                    .padding()
                }
                Spacer()
                HStack {
                    TwoButtonsView(primaryButtonText: LocalizedString.Buttons.nextStepTimeTitle,
                                   secondaryButtonText: LocalizedString.Buttons.previousTitle, primaryAction: {
                        
                    }, secondaryAction: {
                        dismiss()
                    })
                        .frame(height: 60)
                }
            }
//            .calendarSheet(presented: $startDateCalendarPresented, dateStr: $viewModel.startDate)
//            .calendarSheet(presented: $endDateCalendarPresented, dateStr: $viewModel.endDate)
//            .durationSheet(presented: $durationPresented, duration: $viewModel.duration)
            .bottomSheet(isPresented: $startDateCalendarPresented, contentView: {
                VStack {
                    HStack{
                        Button {
                            //presented = false
                           // dateStr = Globals.dateFormatter.string(from: calendarDate)
                        } label: {
                            Text(LocalizedString.Buttons.saveTitle)
                                .applyStyle(style: .buttonTitleStyleSecondary)
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                    
                    DatePicker("", selection: $calendarDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .environment(\.calendar, .init(identifier: .persian))
                        .environment(\.locale, Locale.init(identifier: "fa"))
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .applyToolbarWithBackStyle(with: viewModel.header(), backAction: dismiss)

        }
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
            SelectorInoutCell(text: dateText,
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.dateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: durationText,
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
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
            SelectorInoutCell(text: durationText,
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.periodSelectorTitle)
                .onTapGesture {
                    durationPresented = true
                }
            
            SelectorInoutCell(text: startDateText,
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.startDateSelectoreTitle)
                .onTapGesture {
                    startDateCalendarPresented = true
                }
            SelectorInoutCell(text: endDateText,
                              placeholder: LocalizedString.Input.goalSelectorPlaceholder,
                              title: LocalizedString.Input.endDateSelectoreTitle)
                .onTapGesture {
                    endtDateCalendarPresented = true
                }
            RepeatView(weekDays: $weekDays, repeatNum: $repeatNum)
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

