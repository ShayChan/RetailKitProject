//
//  AppDelegate.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AMapServices.shared().enableHTTPS = true
        // 高德地图AppKey
        AMapServices.shared()?.apiKey = "f2936cb1c862bb99c0dae9396532f5e2"
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        // 如果登录了 
        let name = UserDefaults.standard.object(forKey: "userName")
        if name == nil {
            self.window?.rootViewController = RKLoginVC()
        }else {
            self.window?.rootViewController = RKTabBarVC()
        }
        self.window?.makeKeyAndVisible()
        // 全局启用
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().tintColor = .black
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token: NSMutableString = NSMutableString(format: "%@", deviceToken as CVarArg)
        token.replaceOccurrences(of: " ", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
        token.replaceOccurrences(of: "<", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))
        token.replaceOccurrences(of: ">", with: "", options: NSString.CompareOptions.caseInsensitive, range: NSMakeRange(0, token.length))

        print("token",token);
    }
    

}

