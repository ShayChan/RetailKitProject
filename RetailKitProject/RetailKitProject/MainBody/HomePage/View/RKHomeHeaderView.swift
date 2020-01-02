//
//  RKHomeHeaderView.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKHomeHeaderView: UICollectionReusableView {
    
//    var view = UIView()
//    var imgView = UIImageView.init(image: UIImage.init(named: "hometopImg"))
    
    var bgView = UIView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupViews()
    }
    
    // MARK: - 计算型属性 赋值
    var newProjectModel :RKProjectListModel?
    var projectModel :RKProjectListModel {
        set {
            self.newProjectModel = newValue
            
            // 可选绑定
            if let tempStr = newValue.project_name {
                nameLabel.text = String(format: "项目名称：%@", tempStr)
            }
            if let tempStr = newValue.external_code {
                codeLabel.text = String(format: "项目代码：%@", tempStr)
            }
            if let tempStr = newValue.start_time {
                startLabel.text = String(format: "开始时间：%@", String.formatTimeStamp(time: tempStr, format: "yyyy-MM-dd"))
            }
            if let tempStr = newValue.end_time {
                endLabel.text = String(format: "结束时间：%@", String.formatTimeStamp(time: tempStr, format: "yyyy-MM-dd"))
            }
        }
        get {
            return self.newProjectModel!
        }
    }
    
    private func setupViews() {
        
        bgView.frame = self.frame
        bgView.backgroundColor = MainColor
        self.addSubview(bgView)
        
        self.addSubview(self.codeLabel)
        codeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
        }
        self.addSubview(self.nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(codeLabel.snp_top).offset(-10)
            make.left.equalTo(codeLabel)
        }
        self.addSubview(self.niLabel)
        niLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(nameLabel.snp_top).offset(-12)
            make.left.equalTo(codeLabel)
        }
        self.addSubview(self.startLabel)
        startLabel.snp.makeConstraints { (make) in
            make.top.equalTo(codeLabel.snp_bottom).offset(10)
            make.left.equalTo(codeLabel);
        }
        self.addSubview(self.endLabel)
        endLabel.snp.makeConstraints { (make) in
            make.top.equalTo(startLabel.snp_bottom).offset(10)
            make.left.equalTo(codeLabel);
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var niLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "姓名: ", titleColor: UIColor.black, fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    
    lazy var nameLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "项目名称: ", titleColor: UIColor.black, fontSize: 14*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    
    lazy var codeLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "项目代码: ", titleColor: UIColor.black, fontSize: 14*ScreenScaleX)
        label.sizeToFit()
        return label
    }()

    lazy var startLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "开始时间: ", titleColor: UIColor.black, fontSize: 14*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    
    lazy var endLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "结束时间: ", titleColor: UIColor.black, fontSize: 14*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
        
}
