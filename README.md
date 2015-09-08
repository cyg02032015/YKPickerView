# YKPickerView

##Use

        picker = YKDatePickerView(frame: CGRect(x: 0, y: 150, width: self.view.width, height: 104))
        picker.delegate = self
        self.view.addSubview(picker)

##Delegate
        extension ViewController: YKDatePickerViewDelegate{
        func selecteCalenderDate(cal: YKCalender) {
        CGLog("\(cal.year)-\(cal.month)-\(cal.day)")
        }
}

### 基本上这些代码就够用了  ，如果想要自定义UI可以改变一下里面的UI布局，逻辑不用变换，希望可以节省大家的时间

