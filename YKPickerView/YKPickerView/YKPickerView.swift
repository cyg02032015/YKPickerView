//
//  YKPickerView.swift
//  YKPickerView
//
//  Created by C on 15/9/5.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit

let ScreenWidth = UIScreen.mainScreen().bounds.width
let ScreenHeight = UIScreen.mainScreen().bounds.height

let cellIdentifier = "Cell"

public class YKPickerView: UIView {

    var delegate: YKPickerViewDelegate!
    var dataSource: YKPickerViewDataSource! {
        didSet {
            configTableView()
        }
    }
    
    
    var containerView: UIView!
    lazy var tableViews = NSMutableArray()
    lazy var dataSourceArr = NSMutableArray()
    lazy var offsets = NSMutableArray()
    var cellHeight: CGFloat = 0
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configPickerView()
    }

    func configPickerView() {
        containerView = UIView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height))
        addSubview(containerView)
        let topLine = UIView(frame: CGRect(x: 12, y: containerView.y + 30, width: self.width - 24, height: 1))
        topLine.backgroundColor = UIColor.redColor()
        self.addSubview(topLine)
        let bottomLine = UIView(frame: CGRect(x: topLine.x, y: topLine.y + 37, width: topLine.width, height: topLine.height))
        bottomLine.backgroundColor = UIColor.redColor()
        self.addSubview(bottomLine)
    }
    
    
    func configTableView() {
        let tableCount = dataSource.numberOfComponentsInYKPickerView(self)
        let W = containerView.width / CGFloat(tableCount)
        let displayCell = dataSource.pickerViewDisPlayCell(self)
        let cellH = containerView.height / CGFloat(displayCell)
        self.cellHeight = cellH
        for i in 0 ..< tableCount {
            let tableView = self.tableView()
            tableView.tag = 1000 + i
            containerView.addSubview(tableView)
            tableViews.addObject(tableView)
        }
        configDataSource()
    }
    //MARK: layoutSubviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        let W = containerView.width / 3
        for i in 0 ..< tableViews.count {
            let tableView = tableViews[i] as! UITableView
            tableView.frame = CGRect(x: CGFloat(i) * W, y: 0, width: W, height: containerView.height)
            tableView.rowHeight = cellHeight
            tableView.contentInset = UIEdgeInsets(top: cellHeight, left: 0, bottom: cellHeight, right: 0)
            let offset = offsets[i] as! CGFloat
            tableView.contentOffset = CGPoint(x: 0, y: cellHeight * (offset - 1))
        }
    }
        
    func configDataSource() {
        let tableCount = dataSource.numberOfComponentsInYKPickerView(self)
        for i in 0 ..< tableCount {
            let mArray = NSMutableArray()
            dataSourceArr.addObject(mArray)
            dataSourceByTabelview(component: i)
        }
    }
    func dataSourceByTabelview(#component: Int) {
        var tvRowsInComponent = 0
        tvRowsInComponent = dataSource.pickerView(self, numberOfRowsInComponent: component)
        var mArray = NSMutableArray()
        for i in 0 ..< tvRowsInComponent {
            let item = YKPickerItem()
            item.title = dataSource.pickerView(self, titleForRow: i, forComponent: component)
            item.component = component
            mArray.addObject(item)
        }
        dataSourceArr.replaceObjectAtIndex(component, withObject: mArray)
    }
    
    func tableView() -> UITableView {
        let tv = UITableView()
        tv.separatorStyle = .None
        tv.backgroundColor = UIColor.lightGrayColor()
        tv.showsVerticalScrollIndicator = false
        tv.dataSource = self
        tv.delegate = self
        tv.decelerationRate = 0
        tv.bounces = false
        tv.registerClass(YKPickerCell.self, forCellReuseIdentifier: cellIdentifier)
        return tv
    }
    
    
    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension YKPickerView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! YKPickerCell
        
        let dataArr = dataSourceArr[tableView.tag - 1000] as! NSArray
        let item = dataArr[indexPath.row] as! YKPickerItem
        cell.item = item
        return cell
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = dataSourceArr[tableView.tag - 1000] as! NSArray
        return rows.count
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let row = selectedCellIndex(sv: scrollView)
        hightLightCellWithRow(row, component: scrollView.tag - 1000)
        componentSelected(scrollView.tag - 1000)

    }
    public func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !scrollView.dragging {
            selectedCellInCenter(scrollView)
        }
    }
    public func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        selectedCellInCenter(scrollView)
    }
    func selectedCellIndex(#sv: UIScrollView) -> Int{
        var offsetY = sv.contentOffset.y
        offsetY += sv.contentInset.top
        var rowF = offsetY / cellHeight
        var rowI = Int(offsetY / cellHeight)
        var row: Int!
        if rowF >= CGFloat(rowI) + 0.5 {
            row = Int(ceil(rowF))
        } else {
            row = Int(floor(rowF))
            
        }
        
        let dataInComponent = dataSourceArr[sv.tag - 1000] as! NSArray
        
        return row
    }
    
    /// 选中的cell移动到中间
    func selectedCellInCenter(sv: UIScrollView) {
        let row = selectedCellIndex(sv: sv)
        var newOffset = CGFloat(row) * cellHeight
        newOffset -= containerView.height / 2 - cellHeight / 2
        sv.setContentOffset(CGPoint(x: 0, y: newOffset), animated: true)
    }
    
    func hightLightCellWithRow(cellIndex: Int, component: Int) {
        let itemArr = dataSourceArr[component] as! NSArray
        for i in 0 ..< itemArr.count {
            let item = itemArr[i] as! YKPickerItem
            item.hilight = i == cellIndex
        }
        let tableView = tableViews[component] as! UITableView
        tableView.reloadData()
    }
    
    func reloadPicker(component: Int, day: Int) {
        if tableViews.count >= component {
            dataSourceByTabelview(component: component)
            let tv = tableViews[component] as! UITableView
            tv.reloadData()
            tv.scrollToRowAtIndexPath(NSIndexPath(forRow: day - 1, inSection: 0), atScrollPosition: UITableViewScrollPosition.None, animated: true)
            hightLightCellWithRow(day - 1, component: component)
        }
    }
    
    func componentSelected(component: Int) {
        delegate.pickerViewDidSelectedComponent(component, row: selectedCellIndex(sv: tableViews[component] as! UIScrollView))
    }
}

protocol YKPickerViewDataSource {
    func numberOfComponentsInYKPickerView(pickerView: YKPickerView) -> Int
    
    func pickerView(ykpickerView: YKPickerView, numberOfRowsInComponent component: Int) -> Int

    func pickerView(ykpickerView: YKPickerView, titleForRow row: Int ,forComponent component: Int) -> String
    func pickerViewDisPlayCell(ykpickerView: YKPickerView) -> Int
}

@objc protocol YKPickerViewDelegate {
    func pickerViewDidSelectedComponent(component: Int, row: Int)
    optional func pikerViewCompleteSelectedRows(rows: NSArray)
}


