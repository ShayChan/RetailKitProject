//
//  RKHomeListCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKHomeListCell: UITableViewCell {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - 点击方法
    
    @objc func checkBtnClick() {
        
        
    }
    
    // MARK: - 计算型属性 赋值
    
//    var newProjectModel :ListModel?
//    var listModel :ListModel {
//        set {
//            self.newProjectModel = newValue
//            if let tempStr = newValue.avatar {
//                iconImgView.kf.setImage(with: URL(string: tempStr))
//            }
//            if let tempStr = newValue.userName {
//                titleLabel.text = tempStr
//            }
//            let lever = UserDefaults.standard.object(forKey: "userInfolevel") as! String
//            //大队长
//            if (lever == "bigCaptain") {
//                if let tempStr = newValue.subordinateNum {
//                    taskNumLabel.text = String(format: "%d人",tempStr)
//                }
//                if let tempStr = newValue.newSubordinateNum {
//                    addTaskNumLabel.text = String(format: "%d人",tempStr)
//                }
//            }else {
//                if let tempStr = newValue.taskNum {
//                    taskNumLabel.text = String(format: "%d条",tempStr)
//                }
//                if let tempStr = newValue.newTaskNum {
//                    addTaskNumLabel.text = String(format: "%d条",tempStr)
//                }
//            }
//        }
//        get {
//            return self.newProjectModel!
//        }
//    }
    
    private func setupViews() {
        
        self.contentView.addSubview(self.iconImgView)
        iconImgView.snp.makeConstraints { (make) in
            make.width.height.equalTo(40*ScreenScaleX)
            make.top.equalTo(self.contentView).offset(15)
            make.left.equalTo(self.contentView).offset(15)
        }
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(iconImgView)
            make.left.equalTo(iconImgView.snp_right).offset(12*ScreenScaleY)
        }
        self.contentView.addSubview(taskLabel)
        taskLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.left.equalTo(titleLabel)
            make.width.equalTo(taskLabel.bounds.size.width)
        }
        self.contentView.addSubview(taskNumLabel)
        taskNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(taskLabel.snp_bottom).offset(12)
            make.centerX.equalTo(taskLabel.snp_centerX)
            make.bottom.equalTo(self.contentView).offset(-15)
        }
        self.contentView.addSubview(addTaskLabel)
        addTaskLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.left.equalTo(self.snp_centerX).offset(15)
            make.width.equalTo(addTaskLabel.bounds.size.width)
        }
        self.contentView.addSubview(addTaskNumLabel)
        addTaskNumLabel.snp.makeConstraints { (make) in
            make.top.equalTo(addTaskLabel.snp_bottom).offset(12)
            make.centerX.equalTo(addTaskLabel.snp_centerX)
        }
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var iconImgView :UIImageView = {
        let img = UIImageView(image: UIImage.init(named: "headerImg"))
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "小明同学", titleColor: RGB(68,68,68), fontSize: 18*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    lazy var taskLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "任务数", titleColor: RGB(140,140,140), fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    lazy var taskNumLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "10人", titleColor: RGB(250,89,96), fontSize: 18*ScreenScaleX)
        label.font = UIFont.systemFont(ofSize: 18*ScreenScaleX, weight: .bold)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var addTaskLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "本周新增任务数", titleColor: RGB(140,140,140), fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    lazy var addTaskNumLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "2人", titleColor: RGB(250,89,96), fontSize: 18*ScreenScaleX)
        label.font = UIFont.systemFont(ofSize: 18*ScreenScaleX, weight: .bold)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    lazy var lineView :UIView = {
        let label = UIView.init()
        label.backgroundColor = LineColor
        return label
    }()
}

