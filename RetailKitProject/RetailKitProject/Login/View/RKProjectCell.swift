//
//  RKProjectCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 19/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKProjectCell: UITableViewCell {
    
    // 闭包的使用
    typealias CheckBtnUpBlock = () ->()

        // 声明闭包
        var checkBtnUpClick :CheckBtnUpBlock?
        // 在global线程里创建一个时间源
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupViews()
        }
    
    // MARK: - 点击方法
        @objc func upBtnClick() {

            if (self.checkBtnUpClick != nil) {
                self.checkBtnUpClick!()
            }
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

            self.contentView.addSubview(self.nameLabel)
            nameLabel.snp.makeConstraints { (make) in
                make.top.left.equalTo(self.contentView).offset(10)
            }
            
            self.contentView.addSubview(self.codeLabel)
            codeLabel.snp.makeConstraints { (make) in
                make.left.equalTo(nameLabel)
                make.top.equalTo(nameLabel.snp_bottom).offset(10)
            }
            
            self.contentView.addSubview(self.startLabel)
            startLabel.snp.makeConstraints { (make) in
                make.top.equalTo(codeLabel.snp_bottom).offset(10)
                make.left.equalTo(nameLabel);
                make.bottom.equalTo(self.contentView).offset(-10)
            }
            
            self.contentView.addSubview(self.endLabel)
            endLabel.snp.makeConstraints { (make) in
                make.top.equalTo(startLabel)
                make.left.equalTo(snp_centerX);
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
            
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
            let label = UILabel.creatLabelWithTitle(title: "开始时间: ", titleColor: UIColor.black, fontSize: 12*ScreenScaleX)
            label.sizeToFit()
            return label
        }()
        
        lazy var endLabel :UILabel = {
            let label = UILabel.creatLabelWithTitle(title: "结束时间: ", titleColor: UIColor.black, fontSize: 12*ScreenScaleX)
            label.sizeToFit()
            return label
        }()
        
    }

