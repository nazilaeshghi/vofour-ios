//
//  TodayViewModel.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 1/23/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import SwiftUI

class WeekViewModel: ObservableObject {    
    private let dataManager: TaskListDataManagable
    @Published var sevenDays: [HeaderDayObject] = DateBuilder.make7Days(selectedDate: Date())
    
    init(dataManager: TaskListDataManagable) {
        self.dataManager = dataManager
        startDate = DateHelper.generalDateFormatter().string(from: Date())
    }
    
    @Published var cards: [CardDisplayModel] = []
    @Published var todayProgressString: String  = ""
    @Published var weekProgressString: String  = ""
    @Published var todayProgress: Float  = 0.0
    @Published var weekProgress: Float  = 0.0
    
    @Published var startDate: String?
    
    func getTasks(date: Date) {
        let tasks = dataManager.fetchTasks(date: date)
        cards = tasks.map { WeekViewModel.transformDataModels(dayRecord: $0) }
        calculateTodayProgress(date: date)
        calculateWeekProgress(selectedDate: date)
    }
    
    func increamentTask(task: CardDisplayModel, date: Date) {
        dataManager.increamentTask(taskID: task.id, date: date)
        getTasks(date: date)
    }
    
    static func transformDataModels(dayRecord: DailyTaskDataModel) -> CardDisplayModel {
        let title = LabelDisplayModel(plainText: dayRecord.task.title)
        let subtitleText = String(dayRecord.record?.count ?? 0).convertToPersian() + "/" + String(dayRecord.task.numberOfRepeat).convertToPersian()
        let subtitle = LabelDisplayModel(plainText: subtitleText, style: .secondaryRegularSubtitle)
        let count = LabelDisplayModel(plainText: String(dayRecord.record?.count ?? 0), style: .regularTitle)
        
        let backhground: Color = dayRecord.task.isActivity ? Color.cellBackgroundColor : Color.disabledColor
        
        let displayModel = CardDisplayModel(title: title,
                                            subtitle: subtitle,
                                            count: count,
                                            color: Color(hex: dayRecord.task.color),
                                            backgroundColor: backhground,
                                            state: dayRecord.state,
                                            progress: dayRecord.progress,
                                            id: dayRecord.task.taskID,
                                            recordID: dayRecord.record?.recordID)
        return displayModel
    }
    
    private func calculateTodayProgress(date: Date) {
        todayProgress = dataManager.fetchDateProgress(date: date)
        let today = Int(todayProgress * 100)
        todayProgressString = today >= 0 ? "%\(today)".convertToPersian() : "%0".convertToPersian()
    }
    
    private func calculateWeekProgress(selectedDate: Date) {
        weekProgress = dataManager.fetchWeekProgress(selectedDate: selectedDate)
        let week = Int(weekProgress * 100)
        weekProgressString = week >= 0 ? "%\(week)".convertToPersian() : "%0".convertToPersian()
    }
    
    func nextDate(for currentDate: Date) -> Date? {
        for (index, item) in sevenDays.enumerated() {
            if item.date == currentDate.getSimpleDate(), let nextDay = sevenDays[safe: index + 1]?.date { return nextDay.date }
        }
        return sevenDays.first?.date
    }
    
    func previousDate(for currentDate: Date) -> Date? {
        for (index, item) in sevenDays.enumerated() {
            if item.date == currentDate.getSimpleDate(), let previousDay = sevenDays[safe: index - 1]?.date { return previousDay.date }
        }
        return sevenDays.last?.date
    }

}


extension DailyTaskDataModel {
    var state: CardState {
        if progress >= 1 && task.isActivity == true {
            return .done
        }
        else if task.isActivity == false,
                progress == 1  {
            return .quitWip
        } else if task.isActivity == false,
                  progress == 0 {
            return .quit
        }
        else {
            return .wip
        }
    }
}
