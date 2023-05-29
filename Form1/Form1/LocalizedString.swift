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
        static let allContexts = "همه زمینه‌ها"
        static let activeContexts = "فعال‌ها"
        static let notActiveContexts = "غیر فعال‌ها"
    }
    
    enum SelectGoalPage {
        static let sectionHeader = "اهداف تعریف شده"
        static let pageHeader = "انتخاب هدف"
        static let buttonTitle = "افزودن هدف جدید"
        static let defaultGoalTitle = "مستقل"
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
        static let dontNeedReminder = "یادآور نیاز ندارم"
        static let addReminder = "افزودن یادآور"
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
        static let reminder = "یادآور"
        
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
        static let numberOfRepeatTitle = "بیش از چندبار در روز این فعالیت را انجام ندهم؟"
    }
    
    enum Tabbar {
        static let week = "هفته"
        static let contexts = "زمینه‌ها"
        static let goals = "اهداف"
        static let add = ""
        static let report = "گزارش"
    }
    
    enum Date {
        static let today = "امروز"
        static let week = "هفته"
    }
    
    enum Home {
        static let activity = "فعالیت"
        static let contextTitle = "زمینه‌ها"
        static let add = "افزودن"
        static let todayProgress = "پیشرفت این هفته"
        static let weekProgress = "پیشرفت امروز"
        static let empty = "برای قرار گرفتن در مسیر رشد\n  از اینجا شروع کن"
    }
    
    
    enum TaskDetail {
        static let create = "ایجاد"
        static let quit = "ترک"
        static let independent = "مستقل"
        static let taskTypeTitle = "نوع فعالیت"
        static let contextTitle = "زمینه"
        static let goalTitle = "هدف"
        static let editButton = "ویرایش"
        static let deleteButton = "حذف"
        static let deleteAlertTitle = "حذف فعالیت"
        static let deletealertSubtitle = "در صورت حذف فعالیت امکان بازیایی آن نیست"
        static let cancel = "لغو"
    }
    
    enum ActicityList {
        static let title = "اهداف"
        static let golas = "اهداف"
        static let contexts = "زمینه‌ها"
        static let currentWeek = "هفته جاری"
        static let allActivities = "کل کار‌ها"
    }
    
    enum Setting {
        static let title = "تنظیمات" 
        static let currentCalendarTitle = "تقویم فارسی"
        static let startDate = "شروع هفته"
        static let saturday = "شنبه"
        static let sunday = "یکشنبه"
        static let monday = "دوشنبه"
        static let tuesday = "سه‌شنبه"
        static let wednesday = "چهارشنبه"
        static let thursday = "پنجشنبه"
        static let friday = "جمعه"
        static let us = "ساخته شده با عشق توسط وداد، حسین، نازیلا و مرتضی"
    }
    
}
