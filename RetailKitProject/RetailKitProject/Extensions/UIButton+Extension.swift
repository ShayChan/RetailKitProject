//
//  UIButton+Extension.swift
//  DawsonICMItem
//
//  Created by Kan 陈 on 2019/10/28.
//  Copyright © 2019 Geometry. All rights reserved.
//

enum DSButtonMode {
    case Top
    case Bottom
    case Left
    case Right
}

import UIKit
 
// UIButton的类方法扩展
extension UIButton {
    
    //这里的类方法相当于OC中的加号方法
    class func creatButtonWithBgColor(bgColor:UIColor, title:String, font:UIFont, titleColor: UIColor) -> UIButton {
        //创建按钮
        let button = UIButton()
        //设置按钮的背景图片
        button.backgroundColor = bgColor
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        //按照背景图片初始化按钮尺寸
        button.sizeToFit()
        //返回按钮
        return button
    }
    
    //这里的类方法相当于OC中的加号方法
    class func creatButtonWithImageName(imageName : String , bgImageName : String) -> UIButton {
        //创建按钮
        let button = UIButton()
        //设置按钮的背景图片
        button.setBackgroundImage(UIImage(named: bgImageName), for: UIControl.State.normal)
        button.setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: UIControl.State.highlighted)
        //设置按钮的图片
        button.setImage(UIImage(named: imageName), for: UIControl.State.normal)
        button.setImage(UIImage(named: imageName + "_highlighted"), for: UIControl.State.highlighted)
        //按照背景图片初始化按钮尺寸
        button.sizeToFit()
        //返回按钮
        return button
        
    }
    /*
     convenience : 便利，使用convenience修饰的构造函数叫做便利构造函数
     便利构造函数通常在对系统的类进行构造函数的扩充时使用
     便利构造函数的特点
     1.便利构造函数通常是写在extension中
     2.便利构造函数init前面需要加载convenience
     3.在便利构造函数中需要明确调用self.init
     */
    convenience init(imageName : String , bgImageName : String) {
        self.init()
        //设置按钮的图片
        setImage(UIImage(named: imageName), for: UIControl.State.normal)
        setImage(UIImage(named: imageName + "_highlighted"), for: UIControl.State.highlighted)
        //设置按钮的背景图片
        setBackgroundImage(UIImage(named: bgImageName), for: UIControl.State.normal)
        setBackgroundImage(UIImage(named: bgImageName + "_highlighted"), for: UIControl.State.highlighted)
        
        //按照背景图片初始化按钮尺寸
        sizeToFit()
        
    }
    
    /// 快速调整图片与文字位置
    ///
    ///   - Parameters:
    ///   - buttonMode: 图片所在位置
    ///   - spacing: 文字和图片之间的间距
    func ds_locationAdjust(buttonMode: DSButtonMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = titleLabel?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont!]) ?? CGSize.zero
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (buttonMode){
        case .Top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .Right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
