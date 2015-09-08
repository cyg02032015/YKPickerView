//
//  ViewController.swift
//  YKPickerView
//
//  Created by C on 15/9/6.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var picker: YKDatePickerView!
    var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        
        picker = YKDatePickerView(frame: CGRect(x: 0, y: 150, width: self.view.width, height: 104))
        picker.delegate = self
        self.view.addSubview(picker)

        label = UILabel(frame: CGRect(x: 0, y: 270, width: ScreenWidth, height: 50))
        label.textAlignment = .Center
        label.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(label)
    }
}

extension ViewController: YKDatePickerViewDelegate{
    func selecteCalenderDate(cal: YKCalender) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.label.text = "\(cal.year)-\(cal.month)-\(cal.day)"
        })
    }

}

