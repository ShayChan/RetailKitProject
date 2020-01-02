//
//  DSNavigationVC.swift
//  DawsonICMIte
//
//  Created by Sammy Chen on 24/10/2019.
//  Copyright © 2019 Sammy Chen. All rights reserved.
//

import UIKit

class RKNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeSet()
    }
    
    // 重写父类的方法 --> 跳转控制器
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 隐藏底部TabBar
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "nav_btn_back_white"), style: .plain, target: self, action: #selector(navItemBack))
        }
        super.pushViewController(viewController, animated: animated)
    }
    // 导航栏返回
    @objc func navItemBack() {
        self.popViewController(animated: true)
    }
    // 重写父类的方法 --> 改变状态栏颜色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    // 重写父类的方法 --> 点击界面退出键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
}

// 扩展的方法

extension RKNavigationVC {
    
    fileprivate func initializeSet() {
        
        // 设置字体大小和颜色
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
        // 设置背景色
        UINavigationBar.appearance().barTintColor = UIColor.white
        // 设置半透明
        UINavigationBar.appearance().isTranslucent = false
        // 设置背景图片
        UINavigationBar.appearance().setBackgroundImage(UIImage(),for: UIBarMetrics.default)
        // 设置阴影图片
//        UINavigationBar.appearance().shadowImage = UIImage()
    }
}
