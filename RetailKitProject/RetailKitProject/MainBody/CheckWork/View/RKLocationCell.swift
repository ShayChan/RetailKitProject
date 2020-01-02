//
//  RKLocationCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 29/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

    
class RKLocationCell: UITableViewCell {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    // MARK: - 点击方法
    
    @objc func feedbackBtnClick() {
        // 反馈定位不准
        
    }
    
    // MARK: - 计算型属性 赋值
    
    private func setupViews() {

        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(18*ScreenScaleX)
            make.width.equalTo(titleLabel.bounds.size.width)
            make.height.equalTo(titleLabel.bounds.size.height)
        }
        
        let attributedStrM : NSMutableAttributedString = NSMutableAttributedString()
        let firstStr = NSAttributedString.init(string: "(距最近的", attributes: [NSAttributedString.Key.backgroundColor : UIColor.white , NSAttributedString.Key.foregroundColor : MainQianTextColor , NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16*ScreenScaleX)])
        let middleStr : NSAttributedString = NSAttributedString(string: "考勤范围", attributes: [NSAttributedString.Key.foregroundColor  : RGB(90,177,211), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16*ScreenScaleX)])
        let lastStr : NSAttributedString = NSAttributedString(string: "1800千米)", attributes: [NSAttributedString.Key.foregroundColor : MainQianTextColor, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16*ScreenScaleX)])
        attributedStrM.append(firstStr)
        attributedStrM.append(middleStr)
        attributedStrM.append(lastStr)
        
        self.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).offset(2)
            make.left.equalTo(titleLabel.snp_right).offset(8)
            make.right.equalTo(self.contentView).offset(-18)
//            make.bottom.equalTo(self.contentView).offset(-18)
        }
        // 赋值
        detailLabel.attributedText = attributedStrM
        
        self.contentView.addSubview(feedbackBtn)
        feedbackBtn.snp.makeConstraints { (make) in
            make.width.equalTo(feedbackBtn.frame.size.width)
            make.height.equalTo(feedbackBtn.frame.size.height)
            make.top.equalTo(detailLabel.snp_bottom)
            make.left.equalTo(detailLabel)
            make.bottom.equalTo(self.contentView).offset(-10*ScreenScaleX)

        }
        
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
            make.left.equalTo(self.contentView).offset(18)
            make.right.equalTo(self.contentView).offset(-18)
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
        let label = UILabel.creatLabelWithTitle(title: "我的位置", titleColor: UIColor.black, fontSize: 18*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    
    lazy var detailLabel :UILabel = {
        let label = UILabel.init()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    
    lazy var lineView :UIView = {
        let label = UIView.init()
        label.backgroundColor = LineColor
        return label
    }()
    
    lazy var feedbackBtn :UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(feedbackBtnClick), for: .touchUpInside)
        btn.setTitle("反馈定位不准", for: .normal)
        btn.setTitleColor(RGB(90,177,211), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0*ScreenScaleX)
        btn.sizeToFit()
        return btn
    }()
}

class RKSeletedStoreCell: UITableViewCell {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    private func setupViews() {

        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(18*ScreenScaleX)
            make.width.equalTo(titleLabel.bounds.size.width)
            make.height.equalTo(titleLabel.bounds.size.height)
        }
        self.contentView.addSubview(storeLabel)
        storeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(18*ScreenScaleX)
            make.left.equalTo(titleLabel)
            make.width.equalTo(storeLabel.bounds.size.width+20)
            make.height.equalTo(storeLabel.bounds.size.height+10)
            make.bottom.equalTo(self.contentView).offset(-18*ScreenScaleX)
        }
        self.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(storeLabel)
            make.left.equalTo(storeLabel.snp_right).offset(8)
        }
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
            make.left.equalTo(self.contentView).offset(18)
            make.right.equalTo(self.contentView).offset(-18)
        }
        self.contentView.addSubview(arrowImgView)
        arrowImgView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.contentView)
            make.width.height.equalTo(20)
            make.right.equalTo(self.contentView).offset(-18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var arrowImgView :UIImageView = {
        let img = UIImageView(image: UIImage.init(named: "arrow"))
        img.contentMode = .scaleAspectFill
        return img
    }()
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "选择门店", titleColor: UIColor.black, fontSize: 18*ScreenScaleX)
        label.sizeToFit()
        return label
    }()    
    lazy var lineView :UIView = {
        let label = UIView.init()
        label.backgroundColor = LineColor
        return label
    }()
    
    lazy var storeLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "门店", titleColor: UIColor.white, fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        label.backgroundColor = MainColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = (label.bounds.size.height+10)/2
        label.sizeToFit()
        label.textAlignment = .center
        return label
    }()
    lazy var detailLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "请选择门店", titleColor: MainQianTextColor, fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
}
