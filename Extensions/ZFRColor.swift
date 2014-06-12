//
//  ZFRColor.swift
//  Hacktracker-ios
//
//  Created by Francesco Frison on 6/12/14.
//  Copyright (c) 2014 Yammer-inc. All rights reserved.
//

import UIKit

extension UIColor {
    
    /** Random Color */
    
    class func randomColor(#alpha: CGFloat) -> UIColor {
        let red : CGFloat =  CGFloat(arc4random() % 255) / 255
        let green : CGFloat =  CGFloat(arc4random() % 255) / 255
        let blue : CGFloat =  CGFloat(arc4random() % 255) / 255
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor.randomColor(alpha: 1.0)
    }
}
