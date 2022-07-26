//
//  TimeIntervalExtension.swift
//  Form1
//
//  Created by Hosseini Zadeh, Morteza on 2022-07-26.
//  Copyright © 2022 Vofour. All rights reserved.
//

import Foundation

extension TimeInterval {
    func getHourAndMin() -> (hour: Int, min: Int) {
        let time = NSInteger(self)
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        return (hours, minutes)
    }
    
    var timeStr: String? {
        let time = self.getHourAndMin()
        if time.min > 0 && time.hour > 0 {
            return "\(time.hour) ".convertToPersian() + "ساعت" + " " + "\(time.min) ".convertToPersian() + "دقیقه"
        } else if time.hour == 0, time.min > 0 {
            return "\(time.min) ".convertToPersian() + "دقیقه"
        } else if time.min == 0, time.hour > 0 {
            return "\(time.hour) ".convertToPersian() + "ساعت"
        } else {
            return nil
        }
    }
}
