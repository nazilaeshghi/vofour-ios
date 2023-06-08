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
    
    @Published var isRepeatable: Int
    @Published var needReminder: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var startDate: String?
    @Published var endDate: String?
    
    @Published var selectedColor: String
    @Published var repeatNum: Int
    @Published var weekDays: [WeekDayObject]
    @Published var selectedDuration: DurationObject?
    @Published var reminders: [TimeObject]
    @Published var endDateError: InputError?
    @Published var reminderError: InputError?
    
    let editMode: Bool
    
    var isItCreation: Bool {
        return dataManager.isTaskActivity()
    }
    
    init(dataManager: TaskCreationStep2DataManagable, editMode: Bool) {
        self.dataManager = dataManager
        if let stDate = dataManager.getStartDate() {
            self.startDate = DateHelper.generalDateFormatter().string(from: stDate)
        }
        if let enDate = dataManager.getEndDate() {
            self.endDate = DateHelper.generalDateFormatter().string(from: enDate)
        }
        self.repeatNum = dataManager.getNumberOfRepeat()
        self.weekDays = dataManager.getWeekDays()
        self.selectedColor = dataManager.getColor()
        self.isRepeatable = dataManager.isRepeatableTask() ? 1 : 0
        
        if dataManager.getReminder().isEmpty {
            self.needReminder = 0
        } else {
            self.needReminder = 1
        }
        
        self.reminders = dataManager.getReminder()
        self.selectedDuration = dataManager.getDuration()
        self.editMode = editMode
    }
    
    func initBinders() {
        self.$isRepeatable
            .sink { [weak self] newValue in
                self?.dataManager.updateTaskType(isRepeatable: newValue == 0 ? false : true )
            }
            .store(in: &cancellables)
        
        self.$needReminder
            .sink { [weak self] newValue in
                if newValue == 0 {
                    self?.reminders = []
                    self?.dataManager.deleteReminders()
                }
            }
            .store(in: &cancellables)
        
        self.$startDate
            .sink { [weak self] newValue in
                let date = DateHelper.generalDateFormatter().optionalDate(from: newValue)
                self?.dataManager.updateStartDate(date: date)
            }
            .store(in: &cancellables)
        
        self.$endDate
            .sink { [weak self] newValue in
                let date = DateHelper.generalDateFormatter().optionalDate(from: newValue)
                self?.dataManager.updatEndDate(date: date)
                if newValue != nil {
                    self?.endDateError = nil
                }
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
        
        self.$reminders
            .sink { [weak self] newValue in
                self?.dataManager.updateReminder(intervals: newValue)
                self?.reminderError = nil
            }
            .store(in: &cancellables)
    }
    
    func header() -> String {
        if editMode {
            return LocalizedString.TaskCreationStep1.editHeader
        } else {
            return LocalizedString.TaskCreationStep1.createHeader
        }
    }
    
    func repetitionSegmentItems() -> [String] {
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
    
    func saveTask() -> Bool{
        if isRepeatable == 1 && endDate == nil {
            endDateError = .endDate
        }
        
        if !isItCreation && endDate == nil {
            endDateError = .endDate
        }
        
        if needReminder == 1 && reminders.count == 0 {
            reminderError = .missingReminder
        }
        
        if reminderError != nil || endDateError != nil {
            return false
        }
        
        dataManager.saveTask()
        return true
    }
    
    func reset() {
        dataManager.resetDataEntry()
    }
}
