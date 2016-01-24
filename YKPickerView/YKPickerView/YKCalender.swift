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
    print("[\(line)], \(function)---:\(message)")
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
//        let calUnits = [NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday]
        let dateComponents = cal!.components([NSCalendarUnit.Era, NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Weekday], fromDate: now)
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
    public func monthsIn(year year: Int) -> [String] {
        var months = [String]()
        for i in 0 ..< MONTHS_COUNT {
            months.append(String(format: "%d", i + 1))
        }
        return months
    }
    public func daysIn(month month: String, year: Int) -> [String] {
        var days = [String]()
        let dateComponents = NSDateComponents()
        dateComponents.year = year
        dateComponents.month = Int(month)!
        dateComponents.day = 1
        let date = greCal.dateFromComponents(dateComponents)
        let range = greCal.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: date!)
        for i in 0 ..< range.length {
            days.append(String(format: "%d", i + 1))
        }
        return days
    }
    
    
}
