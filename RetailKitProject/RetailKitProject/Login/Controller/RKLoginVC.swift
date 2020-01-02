//
//  RKLoginVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 17/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKLoginVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    // 登录接口
    @objc func loginBtnClick() {
        
        let pass1 = "125714".sha1()
        let pass2 = String(format: "%@KfT1b8wCzMWSiG}okj|r_LX=ZBnaN<Y\"#0x?*vtA", pass1)
        let pass3 = pass2.md5
        
        NetworkTools.sharedInstance.loginRequst(parameArr: [nameField.text!,pass3], success: { (respond) in
            // 登录成功
            let respondDict : [String : Any] = respond as! [String : Any]
            let dataDict = respondDict["data"] as! [String: String]
            let name :String = dataDict["staff_name"]!
            // 保存偏好设置 保存用户名
            UserDefaults.standard.set(name, forKey: "userName")
            UserDefaults.standard.synchronize()

            UIApplication.shared.keyWindow?.rootViewController = RKTabBarVC.init()
            
        }) { (error) in
            self.show(text: (error as! String))
        }
    }

// MARK: - 懒加载
    lazy var nameLabel :UILabel = {
        let view = UILabel.init()
        view.text = "RetailKit"
        view.textColor = RGB(83,91,95)
        view.font = UIFont.systemFont(ofSize: 18*ScreenScaleX)
        return view
    }()
    lazy var iconImgView :UIImageView = {
        let photoImgView = UIImageView.init(image: UIImage(named: "RetailKit"))
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
    lazy var bgImgView :UIImageView = {
        let photoImgView = UIImageView.init(image: UIImage(named: "bg"))
        photoImgView.frame = self.view.bounds
        photoImgView.contentMode = .scaleAspectFill
        photoImgView.isUserInteractionEnabled = true
        return photoImgView
    }()
    lazy var nameView :UIView = {
        let view = UIView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 22*ScreenScaleX
        view.layer.borderWidth = 1
        view.layer.borderColor = LineColor.cgColor
        return view
    }()
    lazy var nameImgView :UIImageView = {
        let photoImgView = UIImageView.init(image: UIImage(named: "name_login"))
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
    lazy var nameField :UITextField = {
        let tf = UITextField.init()
        tf.placeholder = "登录账号"
        tf.font = UIFont.systemFont(ofSize: 16*ScreenScaleX)
        tf.clearButtonMode = .whileEditing
        // 测试
        tf.text = "DW149281"
        return tf
    }()
    
    lazy var passView :UIView = {
        let view = UIView.init()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 22*ScreenScaleX
        view.layer.borderWidth = 1
        view.layer.borderColor = LineColor.cgColor
        return view
    }()
    lazy var passImgView :UIImageView = {
        let photoImgView = UIImageView.init(image: UIImage(named: "pass_login"))
        photoImgView.contentMode = .scaleAspectFill
        return photoImgView
    }()
    lazy var passField :UITextField = {
        let tf = UITextField.init()
        tf.placeholder = "登录密码"
        tf.font = UIFont.systemFont(ofSize: 16*ScreenScaleX)
        tf.clearButtonMode = .whileEditing
        // 测试
        tf.text = "125714"
        return tf
    }()

    lazy var loginBtn :UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = MainColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18.0*ScreenScaleX)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 22*ScreenScaleX
        return btn
    }()
}

extension RKLoginVC {
    
    private func prepareUI() {
        
        self.view.addSubview(bgImgView)
        bgImgView.snp_makeConstraints({ (make) in
            make.edges.equalTo(self.view)
        })
        bgImgView.addSubview(iconImgView)
        iconImgView.snp_makeConstraints({ (make) in
            make.width.height.equalTo(80*ScreenScaleX)
            make.top.equalTo(140*ScreenScaleX)
            make.centerX.equalTo(bgImgView)
        })
        bgImgView.addSubview(nameLabel)
        nameLabel.snp_makeConstraints({ (make) in
            make.top.equalTo(iconImgView.snp_bottom).offset(15*ScreenScaleX)
            make.centerX.equalTo(bgImgView)
        })
        
        bgImgView.addSubview(nameView)
        nameView.snp_makeConstraints({ (make) in
            make.top.equalTo(iconImgView.snp_bottom).offset(120*ScreenScaleX)
            make.left.equalTo(bgImgView).offset(40)
            make.right.equalTo(bgImgView).offset(-40)
            make.height.equalTo(44*ScreenScaleX)
        })
        nameView.addSubview(nameImgView)
        nameImgView.snp_makeConstraints({ (make) in
            make.centerY.equalTo(nameView)
            make.left.equalTo(nameView).offset(24)
            make.width.height.equalTo(22)
        })
        nameView.addSubview(nameField)
        nameField.snp_makeConstraints({ (make) in
            make.left.equalTo(nameImgView.snp_right).offset(20)
            make.top.bottom.equalTo(nameView)
            make.right.equalTo(nameView).offset(-30)
        })
        
        bgImgView.addSubview(passView)
        passView.snp_makeConstraints({ (make) in
            make.top.equalTo(nameView.snp_bottom).offset(22*ScreenScaleX)
            make.left.equalTo(bgImgView).offset(40)
            make.right.equalTo(bgImgView).offset(-40)
            make.height.equalTo(44*ScreenScaleX)
        })
        passView.addSubview(passImgView)
        passImgView.snp_makeConstraints({ (make) in
            make.centerY.equalTo(passView)
            make.left.equalTo(passView).offset(24)
            make.width.height.equalTo(22)
        })
        passView.addSubview(passField)
        passField.snp_makeConstraints({ (make) in
            make.left.equalTo(passImgView.snp_right).offset(20)
            make.top.bottom.equalTo(passView)
            make.right.equalTo(passView).offset(-30)
        })
        
        bgImgView.addSubview(loginBtn)
        loginBtn.snp_makeConstraints({ (make) in
            make.top.equalTo(passView.snp_bottom).offset(22*ScreenScaleX)
            make.left.equalTo(bgImgView).offset(40)
            make.right.equalTo(bgImgView).offset(-40)
            make.height.equalTo(44*ScreenScaleX)
        })
    }
    
}
