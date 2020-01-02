//
//  RKTakePhotoCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 29/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

// 闭包的使用
typealias TakePhotoBlock = () ->()
// 照片赋值
typealias SetValueBlock = (_ photo:UIImage) ->()
// 点击放大照片
typealias ScalePhotoBlock = (_ photo:UIImage) ->()


// 代理模式
//@objc protocol RKTakePhotoCellDelegate {
//
//   func SetValueBlock(photoImg: UIImage)
//}
    
class RKTakePhotoCell: UITableViewCell {
    
    // 代理属性
//    weak var delegate: RKTakePhotoCellDelegate?

    // 声明闭包
    var takePhotoBlockClick :TakePhotoBlock?
    var setValueBlock :SetValueBlock?
    var scalePhotoBlockClick :ScalePhotoBlock?

    // 照片
    var photoImg:UIImage?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        // 实现照片赋值block
        self.setValueBlock = { (photoImg:UIImage) in
            self.photoImg = photoImg
            self.photoImgBtn .setImage(photoImg, for: .normal)
            self.deletedBtn.isHidden = false
            self.photoBtn.isEnabled = false
        }
    }
    
    
    // MARK: - 点击方法
    
    @objc func photoBtnClick() {
        if (self.takePhotoBlockClick != nil) {
            self.takePhotoBlockClick!()
        }
    }
    
    @objc func deletedBtnClick() {
    // 点击删除照片
        self.photoImgBtn .setImage(nil, for: .normal)
        self.deletedBtn.isHidden = true
        self.photoBtn.isEnabled = true
        self.photoImg = nil
    }
    
    @objc func photoImgBtnClick() {
        if self.photoImg != nil {
            // 点击照片放大
            if (self.scalePhotoBlockClick != nil) {
                self.scalePhotoBlockClick!(self.photoImg!)
            }
        }else {
            return
        }
    
    }
    
    private func setupViews() {

        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(18)
            make.width.equalTo(titleLabel.bounds.size.width)
            make.height.equalTo(titleLabel.bounds.size.height)
        }
        
        self.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(4)
            make.left.equalTo(titleLabel)
        }
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(self.contentView)
            make.height.equalTo(1)
            make.left.equalTo(self.contentView).offset(18)
            make.right.equalTo(self.contentView).offset(-18)
        }
        self.contentView.addSubview(photoBtn)
        photoBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(16)
            make.right.equalTo(lineView)
            make.width.height.equalTo(60*ScreenScaleX)
            make.bottom.equalTo(self.contentView).offset(-16)
        }
        self.contentView.addSubview(photoImgBtn)
        photoImgBtn.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(16)
            make.left.equalTo(titleLabel.snp_right).offset(50)
            make.width.height.equalTo(60*ScreenScaleX)
            make.bottom.equalTo(self.contentView).offset(-16)
        }
        self.contentView.addSubview(deletedBtn)
        deletedBtn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.photoImgBtn.snp_right)
            make.centerY.equalTo(self.photoImgBtn.snp_top)
            make.width.height.equalTo(20*ScreenScaleX)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var photoBtn :UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: "paizhao"), for: .normal)
        btn.backgroundColor = .white
        btn.layer.borderColor = LineColor.cgColor
        btn.layer.borderWidth = 1
        btn.addTarget(self, action: #selector(photoBtnClick), for: .touchUpInside)
        return btn
    }()
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "拍照", titleColor: UIColor.black, fontSize: 18*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    lazy var detailLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "(必填)", titleColor: MainQianTextColor, fontSize: 16*ScreenScaleX)
        label.sizeToFit()
        return label
    }()
    lazy var lineView :UIView = {
        let label = UIView.init()
        label.backgroundColor = LineColor
        return label
    }()
    lazy var photoImgBtn :UIButton = {
        let btn = UIButton()
        btn.contentMode = .scaleAspectFill
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(photoImgBtnClick), for: .touchUpInside)
        return btn
    }()
    lazy var deletedBtn :UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(deletedBtnClick), for: .touchUpInside)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10*ScreenScaleX
        btn.backgroundColor = UIColor.red
        btn.setTitle("一", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0*ScreenScaleX)
        btn.isHidden = true
        return btn
    }()
}
