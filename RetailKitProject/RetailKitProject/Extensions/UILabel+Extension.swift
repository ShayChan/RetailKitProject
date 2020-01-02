//
//  UILabel+Extension.swift
//  DawsonICMItem
//
//  Created by Kan 陈 on 2019/10/29.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

    // UIButton的类方法扩展
    extension UILabel {
        
        //这里的类方法相当于OC中的加号方法
        class func creatLabelWithTitle(title :String, titleColor :UIColor, fontSize :CGFloat) -> UILabel {
            //创建按钮
            let label = UILabel()
            //设置按钮的背景图片
            label.text = title
            label.textColor = titleColor
            label.font = UIFont.systemFont(ofSize: fontSize)
            //按照背景图片初始化按钮尺寸
            label.sizeToFit()
            //返回按钮
            return label
        }

}
