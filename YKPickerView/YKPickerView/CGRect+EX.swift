//
//  CGRect+EX.swift
//  Zhaoshi365
//
//  Created by C on 15/8/28.
//  Copyright (c) 2015年 YoungKook. All rights reserved.
//

import UIKit


extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var width: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var top: CGFloat {
        get {
            return y
        }
        set {
            y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return y + height
        }
    }
    
    var left: CGFloat {
        get {
            return x
        }
    }
    
    var right: CGFloat {
        get {
            return x + width
        }
    }
    
    var midX: CGFloat {
        get {
            return self.x + self.width / 2
        }
    }
    
    var midY: CGFloat {
        get {
            return self.y + self.height / 2
        }
    }
    
}