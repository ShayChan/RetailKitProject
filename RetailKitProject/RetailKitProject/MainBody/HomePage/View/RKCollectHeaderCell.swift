//
//  RKCollectHeaderCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 2/1/2020.
//  Copyright © 2020 Geometry. All rights reserved.
//

import UIKit

class RKCollectHeaderCell: UICollectionViewCell {
    
    override init(frame:CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
    //        // MARK: - 计算型属性 赋值
    //        var newProjectModel :RKHomeColleModel?
    //        var projectModel :RKHomeColleModel {
    //            set {
    //                self.newProjectModel = newValue
    //
    //                // 可选绑定
    //                if newValue.model_name!.length>0 {
    //                    titleLabel.text = newValue.model_name!
    //                    titleLabel.textColor = MainDetailTextColor
    //                }
    //
    //                if newValue.model_logo!.length>0 {
    //                    let url = String(format: "%@%@", baseUrl,newValue.model_logo!)
    //                    iconImgView.kf.setImage(with: URL(string: url))
    //                }else {
    //                    iconImgView.image = UIImage.init(named: "jurassic")
    //                }
    //                if newValue.model_logo == "home_icon"{
    //                    iconImgView.image = UIImage.init(named: newValue.model_logo!)
    //                }
    //            }
    //            get {
    //                return self.newProjectModel!
    //            }
    //        }
    //
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupUI() {
            
            self.contentView.backgroundColor = .yellow
            
            self.contentView.addSubview(iconImgView)
            iconImgView.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.contentView)
                make.left.equalTo(self.contentView).offset(30)
                make.width.height.equalTo(60*ScreenScaleX)
            }
            
//            iconBgView.addSubview(iconImgView)
//            iconImgView.snp.makeConstraints { (make) in
//                make.center.equalTo(iconBgView)
//                make.width.height.equalTo(24*ScreenScaleX)
//            }

            self.contentView.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(iconImgView)
                make.left.equalTo(iconImgView.snp_right).offset(20)
            }
            
            self.contentView.addSubview(subLabel)
            subLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(iconImgView)
                make.left.equalTo(iconImgView.snp_right).offset(20)
            }
            
//            self.contentView.addSubview(arrowImgView)
//            arrowImgView.snp.makeConstraints { (make) in
//                make.centerY.equalTo(self.contentView)
//                make.right.equalTo(self.contentView).offset(-15)
//                make.width.height.equalTo(16*ScreenScaleX)
//            }
            
        }
        
        lazy var iconBgView :UIView = {
            let img = UIView.init()
            img.backgroundColor = MainColor
            img.layer.masksToBounds = true
            img.layer.cornerRadius = 4
            return img
        }()
        lazy var iconImgView :UIImageView = {
            let img = UIImageView.init(image: UIImage.init(named: "icon_default"))
            img.contentMode = .scaleAspectFill
            img.layer.masksToBounds = true
            img.layer.cornerRadius = 25
            return img
        }()
        lazy var titleLabel :UILabel = {
            let label = UILabel.creatLabelWithTitle(title: "姓名", titleColor: UIColor.black, fontSize: 18*ScreenScaleX)
            label.sizeToFit()
            return label
        }()
        
        lazy var subLabel :UILabel = {
            let subLabel = UILabel.creatLabelWithTitle(title: "工号：", titleColor: MainQianTextColor, fontSize: 14*ScreenScaleX)
            subLabel.sizeToFit()
            return subLabel
        }()
//
//        lazy var arrowImgView :UIImageView = {
//            let img = UIImageView.init(image: UIImage.init(named: "arrow"))
//            img.contentMode = .scaleAspectFill
//            return img
//        }()
}
