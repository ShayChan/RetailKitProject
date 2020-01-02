//
//  UIColor+Extension.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 1/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

extension UIColor {

    //返回随机颜色
    open class var randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
