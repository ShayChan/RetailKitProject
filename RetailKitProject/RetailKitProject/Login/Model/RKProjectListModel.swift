//
//  RKSeleteModel.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 19/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit

class RKProjectListModel: BaseModel {
    
    /*
     {
         "code": 200,
         "message": "\u6570\u636e\u8c03\u7528\u6210\u529f",
         "data": {
             "page": {
                 "page_num": 0,
                 "page_size": 20,
                 "page_count": 1
             },
             "list": [{
                 "_id": {
                     "$oid": "5df886e4a786ce36d950cf1e"
                 },
                 "external_code": "DEV_EXTENAL_001",
                 "internal_code": "DEV_19010",
                 "project_name": "RetailKit\u4f53\u9a8c\u9879\u76ee",
                 "start_time": 1576568525,
                 "end_time": 1609430400,
                 "update_time": 1576568548,
                 "status": 1,
                 "schedule": {
                     "schedule_code": "DEV_EXTENAL_001_1",
                     "start_time": 1576739436,
                     "end_time": 1609430400,
                     "status": 1,
                     "update_time": 1576739455
                 }
             }]
         }
     }
     */
    
    private var _projectId :String?
    var projectId :String? {
        get {
            return _projectId
        }
        set {
            _projectId = newValue
        }
    }
    var _id :[String:String]?
    // 外部代码
    var external_code:String?
//    var $oid:String?

    // 内部代码
    var internal_code:String?
    // 项目名
    var project_name:String?
    // 开始时间
    var start_time:Int?
    // 结束时间
    var end_time:Int?
    var update_time:Int?
    // 可用1 不可用0
    var status:String?
    var schedule :ScheduleModel?

}
class ScheduleModel: BaseModel {

    /*
     "schedule": {
         "schedule_code": "DEV_EXTENAL_001_1",
         "start_time": 1576739436,
         "end_time": 1609430400,
         "status": 1,
         "update_time": 1576739455
     }
     */
    var schedule_code :String?
    var start_time :Int?
    var end_time :Int?
    var status :String?
    var update_time :String?
}

class ProIdModel: BaseModel {

    /*
     "_id": {
         "$oid": "5df886e4a786ce36d950cf1e"
     }
     */
//    var $oid :String?

}
