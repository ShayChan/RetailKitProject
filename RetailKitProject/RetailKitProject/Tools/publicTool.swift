//
//  publicTool.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 28/10/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import Foundation
import UIKit


//weak var weakSelf = self

// 适配参数
public let kNavigationBarHeight = 44.0
public let kStatusBarHeight = IS_IPHONEXAll ? 44.0 : 20.0
public let kSafeAreaTopHeight = IS_IPHONEXAll ? 88.0 : 64.0
public let kSafeAreaBottomHeight:CGFloat = IS_IPHONEXAll ? 34 : 0
public let kTabbarHeight = 49.0

public let kScreenWidth     = UIScreen.main.bounds.size.width
public let kScreenHeight    = UIScreen.main.bounds.size.height
public let ScreenScaleX = UIScreen.main.bounds.size.width/375.0
public let ScreenScaleY = UIScreen.main.bounds.size.height/667.0;

/************************application相关*******************/
/// 当前app版本号
public let KAppCurrentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
/// 当前app的build号
public let KAppBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
/// 获取设备当前系统
public let KSystemVersion = UIDevice.current.systemVersion

// 2. 全局函数
public func isIphoneX() -> Bool {
    if UIScreen.main.bounds.height == 812 {
        return true
    }
    return false
}

public let IS_IPHONEXAll = UIScreen.main.bounds.height >= 812 ? true : false

// 3.计算属性

public var isDebug: Bool {
    #if DEBUG
    return true
    #else
    return false
    #endif
}

// 4.闭包类型的常量

// 通过 red 、 green 、blue 颜色数值
public let RGB:((Float,Float,Float) -> UIColor) = { (r: Float, g: Float , b: Float) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: 1.0)
}

// 通过 red 、 green 、blue 、alpha 颜色数值
public let RGBAlpa:((Float,Float,Float,Float) -> UIColor) = { (r: Float, g: Float , b: Float , a: Float ) -> UIColor in
    return UIColor.init(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}

// 主题色
//public let MainColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 101/255.0, alpha: 1)
let MainColor = RGB(77,167,252)
let MainQianColor = RGB(149,202,245)

// 数字主题色
public let CodeColor = UIColor.init(red: 90/255.0, green: 147/255.0, blue: 225/255.0, alpha: 1)
// 线条主题色
public let LineColor = RGB(203,203,203)
// 主题背景色
public let MainBackgroundColor = RGB(237,237,237)
// 全局圆角
public let mainRadius : CGFloat = 8
// detail字体色
public let MainDetailTextColor = RGB(51,51,51)
// text浅色
public let MainQianTextColor = RGB(153,153,153)
/// RGB颜色 ＋ 透明
func RGBColor_A(_ r:CGFloat,_ g : CGFloat, _ b : CGFloat, _ p : CGFloat) -> UIColor {
    return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: p)
}
// 钥匙串
private var UUID : NSString?

public func getUUID()->String {
    let UUIDDate = SSKeychain.passwordData(forService: "com.magic.bang", account: "com.magic.bang")
    if UUIDDate != nil {
        UUID = NSString(data: UUIDDate!, encoding: String.Encoding.utf8.rawValue)
    }
    if(UUID == nil) {
        UUID = UIDevice.current.identifierForVendor!.uuidString as NSString
        SSKeychain.setPassword(UUID! as String, forService: "com.magic.bang", account: "com.magic.bang")
    }
    return UUID! as String
}

let kPrintLog = 1  // 控制台输出开关 1：打开   0：关闭
// 控制台打印
func PLog(item: Any...) {
    if kPrintLog == 1 {
        print(item.last!)
    }
}
//public func device_token()->String {
//     var deviceTokenString = String()
//           let bytes = [UInt8](deviceToken)
//           for item in bytes {
//               deviceTokenString += String(format:"%02x", item&0x000000FF)
//           }
//          printLog("deviceToken：\(deviceTokenString)")
//
//
//}

