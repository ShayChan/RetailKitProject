//
//  RKHomeCollectCell.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 28/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import Kingfisher

class RKHomeCollectCell: UICollectionViewCell {

        
//   var imageView: UIImageView!
//   var titleLabel: UILabel!
    
    override init(frame:CGRect){
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK: - 计算型属性 赋值
    var newProjectModel :RKHomeColleModel?
    var projectModel :RKHomeColleModel {
        set {
            self.newProjectModel = newValue
            
            // 可选绑定
            if newValue.model_name!.length>0 {
                titleLabel.text = newValue.model_name!
                titleLabel.textColor = MainDetailTextColor
            }
            
            if newValue.model_logo!.length>0 {
                let url = String(format: "%@%@", baseUrl,newValue.model_logo!)
                iconImgView.kf.setImage(with: URL(string: url))
            }else {
                iconImgView.image = UIImage.init(named: "jurassic")
            }
            if newValue.model_logo == "home_icon"{
                iconImgView.image = UIImage.init(named: newValue.model_logo!)
            }
        }
        get {
            return self.newProjectModel!
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        
        self.contentView.addSubview(iconImgView)
        iconImgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(30)
            make.centerX.equalTo(self.contentView)
            make.width.height.equalTo(44*ScreenScaleX)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(iconImgView.snp_bottom).offset(15)
            make.centerX.equalTo(self.contentView)
            make.left.equalTo(2)
            make.right.equalTo(-2)
        }
        
        self.backgroundColor = UIColor.white
    }
    
    lazy var iconImgView :UIImageView = {
        let img = UIImageView.init()
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    lazy var titleLabel :UILabel = {
        let label = UILabel.creatLabelWithTitle(title: "项目", titleColor: UIColor.white, fontSize: 12*ScreenScaleX)
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        let frame:CGRect = self.bounds
//        let imgx:CGFloat = 5.0
//        let imgy = imgx
//
//        let frameWidth:CGFloat = frame.size.width
//        let imgWidth:CGFloat = frameWidth - (imgx * 2.0)
//
//        self.imageView.frame = CGRect(x: imgx, y: imgy, width: imgWidth, height: imgWidth)
//        self.titleLabel.frame = CGRect(x: 0, y:imgy+frameWidth , width: frameWidth, height: 20)
//
//    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
}
