//
//  RKSignCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 9/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

let currentColor = RGB(245,227,169)
    
class RKSignCell: UITableViewCell {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - 点击方法
    
    @objc func signBtnClick() {
        
        print("门店巡到")
        
    }
    
    private func setupViews() {

        //  签到按钮
        self.contentView.addSubview(signBtn)
        signBtn.snp.makeConstraints { (make) in
            make.width.equalTo(220*ScreenScaleX)
            make.height.equalTo(80*ScreenScaleX)
            make.top.equalTo(self.contentView).offset(40*ScreenScaleX)
            make.centerX.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-40*ScreenScaleX)
        }
        signBtn.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { (make) in
            make.left.equalTo(signBtn).offset(30*ScreenScaleX)
            make.width.height.equalTo(40*ScreenScaleX)
            make.centerY.equalTo(signBtn)
        }
        signBtn.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(iconImgView.snp_right).offset(15*ScreenScaleX)
            make.width.equalTo(1)
            make.height.equalTo(iconImgView)
            make.centerY.equalTo(signBtn)
        }
        signBtn.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(lineView.snp_right).offset(18*ScreenScaleX)
            make.width.equalTo(titleLabel.frame.size.width)
            make.height.equalTo(titleLabel.frame.size.height)
            make.bottom.equalTo(signBtn.snp_centerY).offset(-2)
        }
        signBtn.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.width.equalTo(titleLabel.frame.size.width)
            make.height.equalTo(titleLabel.frame.size.height)
            make.top.equalTo(signBtn.snp_centerY).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var iconImgView :UIImageView = {
        let img = UIImageView(image: UIImage.init(named: "sign_btn"))
        img.contentMode = .scaleAspectFill
        return img
    }()
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "门店巡到", titleColor: .white, fontSize: 18*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    
    lazy var timeLabel :UILabel = {
        let label = UILabel.init()
        label.text = "15:30"
        label.textColor = currentColor
        label.sizeToFit()
        return label
    }()
    
    lazy var lineView :UIView = {
        let label = UIView.init()
        label.backgroundColor = currentColor
        return label
    }()
    
    lazy var signBtn :UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(signBtnClick), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 40*ScreenScaleX
        btn.backgroundColor = MainColor
        btn.sizeToFit()
        return btn
    }()
}

