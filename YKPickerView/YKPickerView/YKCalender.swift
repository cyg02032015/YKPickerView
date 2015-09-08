//
//  YKCalender.swift
//  YKPicerkView
//
//  Created by C on 15/9/4.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit

// 打印
func CGLog<T>(message: T, line: Int = __LINE__, function: String = __FUNCTION__, file: String = __FILE__) {
    println("[\(line)], \(function)---:\(message)")
}




let MONTHS_COUNT: Int = 12
let DAYS_COUNT: Int = 31


public class YKCalender: NSObject {
    ///日历年份起始值
    var yearStart: Int!
    ///日历年份终点值
    var yearEnd: Int!
    ///日历类
    var greCal: NSCalendar!
    ///年代
    var era: String!
    var year: String!
    var month: String!
    var day: String!
    var weekday: String!
    lazy var weekdays = [String]()
    public convenience init(start: Int, end: Int) {
        self.init()
        self.yearStart = start
        self.yearEnd = end
        
        let cal = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        cal?.timeZone = NSTimeZone.defaultTimeZone()
        greCal = cal
        weekdays = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let now = NSDate()
        let calUnit = NSCalendarUnit.CalendarUnitEra | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond | NSCalendarUnit.CalendarUnitWeekday
        let dateComponents = cal!.components(calUnit, fromDate: now)
        era = String(format: "%d", dateComponents.era)
        year = String(format: "%d", dateComponents.year)
        month = String(format: "%d", dateComponents.month)
        day = String(format: "%d", dateComponents.day)
        weekday = String(format: "%d", dateComponents.weekday)
        
        
    }
    public func yearsInRange() -> [String]{
        var years = [String]()
        for i in yearStart ... yearEnd {
            years.append(String(format: "%d", i))
        }
        return years
    }
    public func monthsIn(#year: Int) -> [String] {
        var months = [String]()
        for i in 0 ..< MONTHS_COUNT {
            months.append(String(format: "%d", i + 1))
        }
        return months
    }
    public func daysIn(#month: String, year: Int) -> [String] {
        var days = [String]()
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = month.toInt()!
        dateComponents.day = 1
        let date = greCal.dateFromComponents(dateComponents)
        let range = greCal.rangeOfUnit(NSCalendarUnit.CalendarUnitDay, inUnit: NSCalendarUnit.CalendarUnitMonth, forDate: date!)
        for i in 0 ..< range.length {
            days.append(String(format: "%d", i + 1))
        }
        return days
    }
    
    
}
