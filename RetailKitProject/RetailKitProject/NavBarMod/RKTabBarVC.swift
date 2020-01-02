//
//  DSTabBarVC.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 25/10/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 选中改变字体颜色
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.disabled)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: MainColor], for:.normal)
        
        
        
        let study = RKStudyPageVC()
//        let check = RKCheckWorkVC()
        let check = RKPunchClockVC()
        let home = RKHomePageVC()
        let sign = RKSigninPageVC()
        let my = RKMyPageVC()

        self.addChildVC(study, itemTitle: "学习", imageN: "study_nor", selImageN: "study_did")
        self.addChildVC(check, itemTitle: "考勤", imageN: "check_nor", selImageN: "check_did")
        self.addChildVC(home, itemTitle: "首页", imageN: "home_nor", selImageN: "home_did")
        self.addChildVC(sign, itemTitle: "签到", imageN: "sign_nor", selImageN: "sign_did")
        self.addChildVC(my, itemTitle: "我的", imageN: "my_nor", selImageN: "my_did")
        
        self.selectedIndex = 2
    }
    
}

extension RKTabBarVC {
    
    // 添加子控制器
    fileprivate func addChildVC(_ vc: UIViewController, itemTitle: NSString, imageN: NSString, selImageN: NSString) {
        
        var image : UIImage = UIImage(named: imageN as String)!
        var selImage : UIImage = UIImage(named: selImageN as String)!
        image = image.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        selImage = selImage.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        vc.tabBarItem = UITabBarItem.init(title: itemTitle as String, image: image, selectedImage: selImage)
        
        vc.title = itemTitle as String
        let nav = RKNavigationVC(rootViewController: vc)
        addChild(nav)
    }
}

