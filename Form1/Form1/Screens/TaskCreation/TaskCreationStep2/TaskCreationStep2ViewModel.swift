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
    @Published var weekDays: [WeekDayObject] = WeekDayBuilder.build()
    @Published var duration: TimeInterval = 0
    @Published var durationStr: String?
    
    init(dataManager: TaskCreationStep2DataManagable) {
        self.dataManager = dataManager
        initBinders()
    }
    
    func initBinders() {
        self.$isRepeatable
            .sink { [weak self] newValue in
                self?.dataManager.updateTaskType(isRepeatable: newValue == 0 ? false : true )
            }
            .store(in: &cancellables)
        
        self.$startDate
            .sink { [weak self] newValue in
                let date = Globals.dateFormatter.optionalDate(from: newValue)
                self?.dataManager.updateStartDate(date: date)
            }
            .store(in: &cancellables)
        
        self.$endDate
            .sink { [weak self] newValue in
                let date = Globals.dateFormatter.optionalDate(from: newValue)
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
        
        self.$duration
            .sink { [weak self] newValue in
                self?.dataManager.updatDuration(interval: newValue)
                if newValue == 0.0 {
                    self?.durationStr = nil
                } else {
                    let time = newValue.getHourAndMin()
                    self?.durationStr = "\(time.hour)".convertToPersian() + "ساعت" + " " + "\(time.min)".convertToPersian() + "دقیقه"
                }
                
            }
            .store(in: &cancellables)
    }
    
    func header() -> String {
        return LocalizedString.TaskCreationStep1.header(context: dataManager.getContextName())
    }
}

extension String {
    func convertEngNumToPersianNum() -> String{
        let format = NumberFormatter()
        format.locale = Locale(identifier: "fa_IR")
        let number =   format.number(from: self)
        
        let faNumber = format.string(from: number!)
        return faNumber!
        
    }
    
    func convertToPersian() -> String {
        let numbersDictionary : Dictionary = ["0" : "۰","1" : "۱", "2" : "۲", "3" : "۳", "4" : "۴", "5" : "۵", "6" : "۶", "7" : "۷", "8" : "۸", "9" : "۹"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        
        return str
    }
}
