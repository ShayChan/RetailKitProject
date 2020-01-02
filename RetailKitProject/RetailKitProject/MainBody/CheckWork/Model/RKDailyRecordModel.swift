//
//  RKDailyRecordModel.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 30/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKDailyRecordModel: BaseModel {
    
    /*
     {
         "code": 200,
         "message": "\u6570\u636e\u8c03\u7528\u6210\u529f",
         "data": {
             "_id": {
                 "$oid": "5e09bb2217a98048396510e2"
             },
             "project": {
                 "project_id": "5df886e4a786ce36d950cf1e",
                 "external_code": "DEV_EXTENAL_001",
                 "project_name": "RetailKit\u4f53\u9a8c\u9879\u76ee",
                 "schedule_code": "DEV_EXTENAL_001_01"
             },
             "store": {
                 "store_id": "5df88ae1ae3b963d33731083",
                 "store_number": "10269007",
                 "store_name": "\u91d1\u6d77\u6e7e\u6d4b\u8bd5\u5e97"
             },
             "staff": {
                 "workno": "DW149281",
                 "staff_name": "\u8096\u6636"
             },
             "date": "2019-12-30",
             "weeknum": "2019#01",
             "on_time": 1577696034,
             "on_photo": "http:\/\/base-serve-icmcenter.gpossible.com\/getFile\/retailkit\/2019-12-30\/3fd71847-ef24-40ff-a251-af966562d4d6.jpg",
             "on_latitude": 23.103377,
             "on_longitude": 113.302457,
             "on_address": "\u5e7f\u4e1c\u7701\u5e7f\u5dde\u5e02\u6d77\u73e0\u533a\u6ee8\u6c5f\u4e1c\u8def\u9760\u8fd1\u91d1\u6d77\u6e7e(\u6ee8\u6c5f\u4e1c\u8def)",
             "duty": [],
             "off_address": "\u5e7f\u4e1c\u7701\u5e7f\u5dde\u5e02\u6d77\u73e0\u533a\u6ee8\u6c5f\u4e1c\u8def\u9760\u8fd1\u91d1\u6d77\u6e7e(\u6ee8\u6c5f\u4e1c\u8def)",
             "off_latitude": 23.103331,
             "off_longitude": 113.302469,
             "off_photo": "http:\/\/base-serve-icmcenter.gpossible.com\/getFile\/retailkit\/2019-12-30\/c352bf78-2a23-4f1e-83cd-dce23407be4d.jpg",
             "off_time": 1577696171
         }
     }
     */
    
    var date:String?
    var weeknum:String?
    var on_time:Int?
    var on_photo:String?
    var on_latitude:String?
    var on_longitude:String?
    var on_address:String?
    var off_address:String?
    var off_latitude:String?
    var off_longitude:String?
    var off_photo:String?
    var off_time:Int?
    var project :ProjectRecordModel?
    var store :StoreRecordModel?
    var staff :StaffRecordModel?

}

class ProjectRecordModel: BaseModel {
    
    var project_id:String?
    // 项目外部项目代码
    var external_code:String?
    var project_name:String?
    var schedule_code:String?
}
class StoreRecordModel: BaseModel {

    var store_id:String?
    var store_number:String?
    var store_name:String?
}
class StaffRecordModel: BaseModel {

    var workno:String?
    // 员工名
    var staff_name:String?

}
