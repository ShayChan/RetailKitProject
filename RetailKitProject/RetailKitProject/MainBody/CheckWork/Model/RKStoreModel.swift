//
//  RKStoreModel.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 23/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKStoreModel: BaseModel {
    
    /*
     {
         "_id": {
             "$oid": "5df88ae1ae3b963d33731083"
         },
         "area": "\u4e1a\u52a1\u5357\u533a",
         "province": "\u5e7f\u4e1c",
         "city": "\u5e7f\u5dde",
         "channel": "\u4e8cA\u7c7b",
         "type": "\u6d4b\u8bd5\u95e8\u5e97",
         "store_name": "\u91d1\u6d77\u6e7e\u6d4b\u8bd5\u5e97",
         "address": "\u5e7f\u4e1c\u7701\u5e7f\u5dde\u5e02\u6d77\u73e0\u533a\u91d1\u6d77\u6e7e",
         "store_number": "10269007",
         "avatar": "",
         "latitude": 23.102929,
         "longitude": 113.302252
     }
     */
    
    private var _storeId :String?
        var storeId :String? {
            get {
                return _storeId
            }
            set {
                _storeId = newValue
            }
        }
    var _id :[String:String]?
    
    var area:String?
    var province:String?
    var city:String?
    var channel:String?
    var type:String?
    var store_name:String?
    var address:String?
    var store_number:String?
    var avatar:String?
    var latitude:String?
    var longitude:String?
}
