//
//  BaseModel.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 1/11/2019.
//  Copyright © 2019年 Geometry. All rights reserved.
//

import UIKit
import HandyJSON


class BaseModel: HandyJSON {
//    var date: Date?
//    var decimal: NSDecimalNumber?
//    var url: URL?
//    var data: Data?
//    var color: UIColor?
    
    required init() {}
    
    func mapping(mapper: HelpingMapper) {   //自定义解析规则，日期数字颜色，如果要指定解析格式，子类实现重写此方法即可
//        mapper <<<
//            date <-- CustomDateFormatTransform(formatString: "yyyy-MM-dd")
//
//        mapper <<<
//            decimal <-- NSDecimalNumberTransform()
//
//        mapper <<<
//            url <-- URLTransform(shouldEncodeURLString: false)
//
//        mapper <<<
//            data <-- DataTransform()
//
//        mapper <<<
//            color <-- HexColorTransform()
      }
}
