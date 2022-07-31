//
//  TaskCreationStep2ViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-15.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TaskCreationStep2ViewModel: ObservableObject {
    private let dataManager: TaskCreationStep2DataManagable
    
    @Published var isRepeatable: Int = 0
    private var cancellables = Set<AnyCancellable>()
    
    @Published var startDate: String?
    @Published var endDate: String?
    
    @Published var selectedColor = StaticColors.colors.first ?? "#EA4C89"
    @Published var repeatNum: Int = 1
    @Published var weekDays: [WeekDayObject] = DateBuilder.buildWeekDays()
    @Published var selectedDuration: DurationObject?
    
    var isItActivity: Bool {
        return dataManager.isTaskActivity()
    }
    
    init(dataManager: TaskCreationStep2DataManagable) {
        self.dataManager = dataManager
    }
    
    func initBinders() {
        self.$isRepeatable
            .sink { [weak self] newValue in
                self?.dataManager.updateTaskType(isRepeatable: newValue == 0 ? false : true )
            }
            .store(in: &cancellables)
        
        self.$startDate
            .sink { [weak self] newValue in
                let date = DateHelper.fullDateFormatter.optionalDate(from: newValue)
                self?.dataManager.updateStartDate(date: date)
            }
            .store(in: &cancellables)
        
        self.$endDate
            .sink { [weak self] newValue in
                let date = DateHelper.fullDateFormatter.optionalDate(from: newValue)
                self?.dataManager.updatEndDate(date: date)
            }
            .store(in: &cancellables)
        
        self.$selectedColor
            .sink { [weak self] newValue in
                self?.dataManager.updateColor(hex: newValue)

            }
            .store(in: &cancellables)
        
        self.$repeatNum
            .sink { [weak self] newValue in
                self?.dataManager.updateNumberOfRepeat(int: newValue)

            }
            .store(in: &cancellables)
        
        self.$weekDays
            .sink { [weak self] newValue in
                self?.dataManager.updateWeekDays(days: newValue)

            }
            .store(in: &cancellables)
        
        self.$selectedDuration
            .sink { [weak self] newValue in
                self?.dataManager.updatDuration(interval: newValue?.amount ?? 0)
            }
            .store(in: &cancellables)
    }
    
    func header() -> String {
        return LocalizedString.TaskCreationStep1.header(context: dataManager.getContextName())
    }
    
    func getSegmentItems() -> [String] {
        if dataManager.isTaskActivity() {
            return [
                LocalizedString.TaskCreationStep2.nonRepeatitiveActivity,
                LocalizedString.TaskCreationStep2.repeatitiveActivity
            ]
        } else {
            return [
                LocalizedString.QuitHabitStep2.quitEntirely,
                LocalizedString.QuitHabitStep2.withLimit
            ]
        }
    }
    
    func saveTask() {
        dataManager.saveTask()
    }
}
