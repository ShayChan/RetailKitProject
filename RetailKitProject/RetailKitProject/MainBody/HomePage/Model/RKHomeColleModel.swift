//
//  RKHomeColleModel.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 19/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKHomeColleModel: BaseModel {
    
    /*
     {
         "code": 200,
         "message": "\u6570\u636e\u8c03\u7528\u6210\u529f",
         "data": {
             "page": {
                 "page_num": 0,
                 "page_size": 1000,
                 "page_count": 2
             },
             "list": [{
                 "_id": {
                     "$oid": "5dfb233e45b080398c7d015d"
                 },
                 "model_number": "SALES",
                 "model_name": "\u9500\u91cf",
                 "model_logo": ""
             }, {
                 "_id": {
                     "$oid": "5dfb241ea786ce36d950cf20"
                 },
                 "model_number": "TEST",
                 "model_name": "\u95ee\u5377\u6d4b\u8bd5",
                 "model_logo": ""
             }]
         }
     }
     */
    private var _modelId :String?
    var modelId :String? {
        get {
            return _modelId
        }
        set {
            _modelId = newValue
        }
    }
      var _id :[String:String]?
       // 模块标识
       var model_number:String?
       // 模块名字
       var model_name:String?
       // 模块图标
       var model_logo:String?
}
