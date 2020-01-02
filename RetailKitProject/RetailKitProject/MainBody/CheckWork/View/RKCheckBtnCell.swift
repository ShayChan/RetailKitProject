//
//  RKCheckBtnCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 1/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

// 闭包的使用
typealias CheckBtnUpBlock = () ->()

class RKCheckBtnCell: UITableViewCell {
    
    var hour:Int!
    var min:Int!
    var sec:Int!


    // 声明闭包
    var checkBtnUpClick :CheckBtnUpBlock?
    // 在global线程里创建一个时间源
    let codeTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    @objc func upBtnClick() {

        if (self.checkBtnUpClick != nil) {
            self.checkBtnUpClick!()
        }
    }
    
    // MARK: - 计算型属性 赋值
    
    var newCurrentTime :String?
    var currentTime :String {
        set {
            self.newCurrentTime = newValue
            if newValue.isEmpty {
                // 为空
                let date = Date.init()
                let format = DateFormatter.init()
                format.dateFormat = "HH:mm:ss"
                let time = format.string(from: date)
                timeLabel.text = time
                timeLabel.textColor = .white
            }else {
                timeLabel.text = newValue
                timeLabel.textColor = .white            }
        }
        get {
            return self.newCurrentTime!
        }
    }
    
    private func setupViews() {

        self.contentView.addSubview(self.upBtn)
        upBtn.snp.makeConstraints { (make) in
            make.width.height.equalTo(180*ScreenScaleX)
            make.centerX.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(40*ScreenScaleX)
            make.bottom.equalTo(self.contentView).offset(-60*ScreenScaleX);
        }
        upBtn.addSubview(insideView)
        insideView.snp.makeConstraints { (make) in
            make.width.height.equalTo(140*ScreenScaleX);
            make.center.equalTo(upBtn);
        }
        insideView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.height.equalTo(titleLabel.frame.size.height);
            make.centerX.equalTo(insideView);
            make.bottom.equalTo(insideView.snp_centerY).offset(-3);
        }
        insideView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.height.equalTo(titleLabel.frame.size.height);
            make.centerX.equalTo(insideView);
            make.top.equalTo(insideView.snp_centerY).offset(3);
        }
//        startGCDTimer() // 开始
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var upBtn :UIButton = {
        let img = UIButton.init()
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 90*ScreenScaleX
        img.backgroundColor = MainQianColor
        img.addTarget(self, action: #selector(upBtnClick), for: .touchUpInside)
        return img
    }()
    lazy var insideView :UIView = {
        let insideView = UIView.init()
        insideView.layer.masksToBounds = true
        insideView.layer.cornerRadius = 70*ScreenScaleX;
        insideView.backgroundColor = MainColor
        insideView.isUserInteractionEnabled = false
        return insideView
    }()
        
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "上班打卡", titleColor: UIColor.white, fontSize: 18*ScreenScaleX)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    lazy var timeLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "09:00:02", titleColor: MainColor, fontSize: 14*ScreenScaleX)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
}

