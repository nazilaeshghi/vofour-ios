//
//  LocalizedString.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 5/30/22.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

struct LocalizedString {
    
    enum ContextPage {
        static let header = "ایجاد فعالیت"
        static let subHeader = "یکی از زمینه‌های زیر را انتخاب کنید."
        static let searchHeader = "زمینه‌ها"
        static let searchPlaceHolder = "جستجو"
    }
    
    enum SelectGoalPage {
        static let sectionHeader = "اهداف تعریف شده"
        static let pageHeader = "انتخاب هدف"
        static let buttonTitle = "افزودن هدف جدید"
        static let defaultGoalTitle = "هدف ندارد و مستقل است"
        static let newGoal = "هدف جدید"
        static let submitNewGoal = "تایید و افزودن"
        static let selectGoalPageTitle = "انتخاب هدف"
    }
    
    enum TaskCreationStep1 {
        static func header(context: String) -> String {
            return "ایجاد فعالیت در زمینه \(context)"
        }
        static let header = "اطلاعات لازم وارد کنید"
        static let createHabitSegmentTitle = "انجام فعالیت"
        static let quitHabitSegmentTitle = "ترک فعالیت"
    }
    
    enum TaskCreationStep2 {
        static let header = "اطلاعات لازم وارد کنید"
        static let repeatitiveActivity = "فعالیت تکرار می‌شود"
        static let nonRepeatitiveActivity = "فعالیت تکرار نمی‌شود"
        
        static let needReminder = "یادآور نیاز دارم"
        static let dontNeedReminder = "یادآور نیاز ندازم"
    }
    
    enum Input {
        static let enterHereTitle = "عنوان فعالیت"
        static let enterHerePlaceholder = "اینجا وارد کنید"
        
        static let obstacleHeader = "پیشگیری"
        static let obstaclePlaceholder = "چه چیز‌هایی موانع این فعالین هستن؟"
        
        static let reasonTitle = "علت انتخاب"
        static let reasonPlaceholder = "قصد شما چیست؟"
        
        static let for100Title = "برای ۱۰۰ شدن چه کاری انجام می‌دهم"
        
        static let goalSelectorTitle = "مستقل یا بخشی از هدف دیگر"
        static let goalSelectorPlaceholder = "انتخاب کنید"
        
        static let dateSelectoreTitle = "تاریخ انجام فعالیت"
        static let startDateSelectoreTitle = "تاریخ آغاز"
        static let endDateSelectoreTitle = "تاریخ پایان"
        static let durationSelectoreTitle = "مدت زمان"
        
        static let periodSelectorTitle = "مدت زمان مورد نیاز انتخاب کنید"
        
        static let numberOfRepeatTitle = "چندبار در روز؟"
        
        static let whichDays = "در چه روز‌هایی از هفته؟"
        static let color = "رنگ نمایشی کارت فعالیت"
    }
    
    enum Buttons {
        static let nextStepTimeTitle = "بعدی: اطلاعات زمان"
        static let previousTitle = "قبلی"
        static let saveTitle = "تایید"
        static let storeDataTitle = "ذخیره"
    }
    
    enum QuitHabitStep2 {
        static let quitEntirely = "ترک کامل"
        static let withLimit = "تعیین حد مجاز"
        static let numberOfRepeatTitle = "بیش از چندبار این فعالیت را انجام ندهم؟"
    }
    
    enum Tabbar {
        static let home = "خانه"
        static let booklet = "سررسید"
        static let activities = "فعالیت‌ها"
        static let add = ""
        static let report = "گزارش"
    }
    
    enum Date {
        static let today = "امروز"
    }
    
}
