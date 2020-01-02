//
//  RKNetworkFuncVC.swift
//  RetailKitProject
//
//  Created by Sammy Chen on 16/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import Alamofire

extension NetworkTools {

    /*
     -  登录接口
     */
    func loginRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        
        parameter["workno"] = parameArr[0]
        parameter["password"] = parameArr[1]
        parameter["udid"] = getUUID().md5
        parameter["platform"] = "ios"
        parameter["device_token"] = getUUID().md5
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))
        
        let url = String(format: "%@/account/login",baseUrl)
        baseFuncRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  获取项目列表
     */
    func getProjectListRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))
        
        let url = String(format: "%@/project/project_list",baseUrl)
        baseFuncGetRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  获取模块列表
     */
    func getModelListRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["project_code"] = parameArr[0]
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))
        
        let url = String(format: "%@/audit/model_list",baseUrl)
        baseFuncGetRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  获取门店列表
     */
    func getStroeListRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        parameter["project_code"] = parameArr[0] // 项目外部代码
        parameter["schedule_code"] = parameArr[1] // 测试 写死
        parameter["page_size"] = "1000"
        parameter["longitude"] = parameArr[2]
        parameter["latitude"] = parameArr[3]
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))

        let url = String(format: "%@/store/store_list",baseUrl)
        baseFuncGetRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  上下班打卡
     */
    func getDailyRecordRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        parameter["project_id"] = parameArr[0] // 项目id
        parameter["store_id"] = parameArr[1] // 门店id
        parameter["type"] = parameArr[2] // 打卡类型 上班还是下班
        parameter["address"] = parameArr[3] // 非必须
        parameter["longitude"] = parameArr[4]
        parameter["latitude"] = parameArr[5]
        parameter["photo"] = parameArr[6] // 非必须
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))

        let url = String(format: "%@/daily/daily_record",baseUrl)
        baseFuncRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  当日考勤详情
     */
    func getRecordDetailRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()

        parameter["date"] = parameArr[0] // 项目id
        let url = String(format: "%@/daily/daily_record_detail",baseUrl)
        baseFuncGetRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
    /*
     -  获取动态表单信息
     */
    func getTemplatedDetailRequst(parameArr:[String],success: @escaping successBlock ,faild: @escaping faildBlock) {
        var parameter = Parameters()
        parameter["project_code"] = parameArr[0] // 项目外部代码
        parameter["store_id"] = parameArr[1] // 门店id
        parameter["schedule_code"] = parameArr[2] // 档期代码
        parameter["model_id"] = parameArr[3] // 模块id
        
        parameter["timestamp"] = Date().timeStamp
        parameter["nonce"] = "456"
        parameter["signature"] = String.md5Str(str: NSString.sign(withDict: parameter))

        let url = String(format: "%@/audit/template_detail",baseUrl)
        baseFuncGetRequst(parameter: parameter,requesUrl: url, success: { (dict) in
            success(dict)
        }) { (error) in
            faild(error)
        }
    }
}
