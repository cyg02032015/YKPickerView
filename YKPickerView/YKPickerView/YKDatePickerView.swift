//
//  ViewController.swift
//  YKPickerView
//
//  Created by C on 15/9/5.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit
protocol YKDatePickerViewDelegate {
    func selecteCalenderDate(cal: YKCalender)
}
class YKDatePickerView: UIView {

    lazy var years = NSArray()
    lazy var months = NSArray()
    lazy var days = NSArray()
    var cal: YKCalender!
    var picker: YKPickerView!
    var delegate: YKDatePickerViewDelegate! {
        didSet{
            setDelegate()
        }
    }
    
    func setDelegate() {
        delegate.selecteCalenderDate(cal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cal = YKCalender(start: 1970, end: 2050)
        setYears()
        setMonthsIn(year: cal.year.toInt()!)
        setDaysIn(month: cal.month, year: cal.year.toInt()!)
        let yearIndex = years.indexOfObject(cal.year)
        let monthIndex = months.indexOfObject(cal.month)
        let dayIndex = days.indexOfObject(cal.day)
        picker = YKPickerView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        picker.offsets = [yearIndex, monthIndex, dayIndex]
        picker.dataSource = self
        picker.delegate = self
        addSubview(picker)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setYears()  {
        years = cal.yearsInRange()
    }
    
    func setMonthsIn(#year: Int)  {
        months = cal.monthsIn(year: year)
    }
    
    func setDaysIn(#month: String, year: Int){
        days = cal.daysIn(month: month, year: year)
    }
}

extension YKDatePickerView: YKPickerViewDataSource, YKPickerViewDelegate {
    func numberOfComponentsInYKPickerView(pickerView: YKPickerView) -> Int {
        return 3
    }
    
    func pickerView(ykpickerView: YKPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return days.count
        default:
            return 0
        }
    }
    
    func pickerView(ykpickerView: YKPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        var rowYear: Int = 0
        var rowMonth: Int = 0
        switch component {
        case 0:
            rowYear = row
            return years[row] as! String
        case 1:
            rowMonth = row
            return months[row] as! String
        case 2:
            return days[row] as! String
        default:
            return ""
        }
    }
    func pickerViewDisPlayCell(ykpickerView: YKPickerView) -> Int {
        return 3
    }
    
    func pickerViewDidSelectedComponent(component: Int, row: Int) {
        
        switch component {
        case 0:
            let yearstr = years[row] as! String
            cal.year = yearstr
            setDaysIn(month: cal.month, year: cal.year.toInt()!)
            picker.reloadPicker(2, day: cal.day.toInt()!)
        case 1:
            let monthstr = months[row] as! String
            cal.month = monthstr
            setDaysIn(month: cal.month, year: cal.year.toInt()!)
            picker.reloadPicker(2, day: cal.day.toInt()!)
        case 2:
            let daystr = days[row] as! String
            cal.day = daystr
            setDaysIn(month: cal.month, year: cal.year.toInt()!)
        default:
            break
        }
        delegate.selecteCalenderDate(cal)
    }
    
    
    
    
    
    
    
}