//
//  YKPickerCell.swift
//  YKPickerView
//
//  Created by C on 15/9/5.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit

class YKPickerCell: UITableViewCell {

    
    var titleLabel: UILabel!
    var item: YKPickerItem! {
        didSet {
            if item.hilight == true {
                switch item.component {
                case 0:
                    titleLabel.text = "\(item.title)年"
                    titleLabel.textColor = UIColor.redColor()
                    titleLabel.font = UIFont.systemFontOfSize(17)
                case 1:
                    titleLabel.text = "\(item.title)月"
                    titleLabel.textColor = UIColor.redColor()
                    titleLabel.font = UIFont.systemFontOfSize(17)
                case 2:
                    titleLabel.text = "\(item.title)日"
                    titleLabel.textColor = UIColor.redColor()
                    titleLabel.font = UIFont.systemFontOfSize(17)
                default:
                    break
                }
            } else {
                    titleLabel.text = item.title
                    titleLabel.textColor = UIColor.blackColor()
                    titleLabel.font = UIFont.systemFontOfSize(15)
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.lightGrayColor()
        titleLabel = UILabel(frame: CGRect(x: 0, y: -5, width: self.width / 3, height: self.height))
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.font = UIFont.systemFontOfSize(15)
        titleLabel.textAlignment = .Center
        self.addSubview(titleLabel)
        
        
        
        
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class YKPickerItem: NSObject {
    var title: String!
    var hilight: Bool!
    var component: Int!
}