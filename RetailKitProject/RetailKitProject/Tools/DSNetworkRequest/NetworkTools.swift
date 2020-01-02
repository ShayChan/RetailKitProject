//
//  NetworkTools.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 12/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import Alamofire
//import HandyJSON
import SwiftyJSON

typealias successBlock = (Any)->()
typealias faildBlock = (Any)->()

enum MethodType {
    case GET
    case POST
}
enum RequestType:Int{
    case JSON = 0
    case FORM
}

class NetworkTools {
//    // 请求链接
//    var requesUrl:String?
    // 设置单例
    static let sharedInstance = NetworkTools()
    
    private init() {}
}
// 设置请求头

let headers: HTTPHeaders = [
    "": ""
]

// baseUrl
public let baseUrl = "http://test2.onemorething.net.cn:5000"
// 公众号版本
let appId = "wxad1a6d19d1e681d7"

let Sys_UDID  = UIDevice.current.identifierForVendor

  // MARK: - 设置为全局变量
  var timeoutSessionManager:Alamofire.SessionManager = {
      let configuration = URLSessionConfiguration.default
      // 请求超时时间15秒
      configuration.timeoutIntervalForRequest = 20
      return Alamofire.SessionManager(configuration: configuration)
  }()

extension NetworkTools {
    
    func request(type: MethodType,url:String,parameters:Parameters? = nil, success: @escaping (_ response: String) -> (),faild: @escaping (_ error: String) -> ()) {
//        print("\(type)"+"/"+"API:"+url)
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        var encodingMethod:ParameterEncoding?
        // 表单还是json
//        if tempRequestType == RequestType.JSON {
//            encodingMethod = JSONEncoding.default
//        }else{
            encodingMethod = URLEncoding.default
//        }
        Alamofire.request(url, method:method,parameters: parameters,encoding:encodingMethod!, headers:headers)//TODO 请求数据json格式
            //HandyJSON需要序列化的是字符串这里是responseString
            .responseString { (response) in
                switch response.result {
                case .success:
                    if let value = response.result.value {
                        success(value)
                    }
                case .failure(let error):
                    faild(error.localizedDescription)
                }
        }
    }
    // baseFunc
    func baseFuncRequst(parameter:[String: Any],requesUrl:String,success: @escaping successBlock ,faild: @escaping faildBlock) {
        
        self.request(type: .POST, url: requesUrl, parameters: parameter, success: { (respond) in
            let dict = respond.getDictionaryFromJSONString(jsonString: respond)
            
            if dict.isEmpty {
                faild("返回空数据")
                return
            }
            let valueStr = dict["code"] as? Int
            if valueStr == 200 {
                success(dict)
            }
            else if valueStr == 409 {
                // 跳转登录
                UIApplication.shared.keyWindow?.rootViewController = RKLoginVC.init()
            }
            else {
                faild(dict["message"] as! String)
            }
        }) { (error) in
            faild(error)
        }
    }
    func baseFuncGetRequst(parameter:[String: Any],requesUrl:String,success: @escaping successBlock ,faild: @escaping faildBlock) {
        
        self.request(type: .GET, url: requesUrl, parameters: parameter, success: { (respond) in
            let dict = respond.getDictionaryFromJSONString(jsonString: respond)
            
            //JSON字符串-->data-->JSON对象(测试发现直接使用JSON(jsonString).arrayValue是转化不出来的)
//            let data = respond.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
            //转成JSON对象
//            let json = JSON.init(data)
            
            if dict.isEmpty {
                faild("返回空数据")
                return
            }
            let valueStr = dict["code"] as? Int
            if valueStr == 200 {
                success(dict)
            }
            else if valueStr == 409 {
                // 跳转登录
                UIApplication.shared.keyWindow?.rootViewController = RKLoginVC.init()
            }
            else {
                faild(dict["message"] as! String)
            }
        }) { (error) in
            faild(error)
        }
    }
}

// MARK: - 工程的请求方法

extension NetworkTools {
                
    /// 图片上传
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: 参数 ["token": "89757", "userid": "nb74110"]
    ///   - images: image数组
    ///   - success: 成功闭包
    ///   - failture: 失败闭包
    func requestUpload(urlString : String, params:[String:String]?, images: [UIImage], success: @escaping (_ response : Any?) -> (), failture : @escaping (_ error : Error)->()) {

        Alamofire.upload(multipartFormData: { multipartFormData in
            if params != nil {
                for (key, value) in params! {
                    //参数的上传
                    multipartFormData.append((value.data(using: String.Encoding.utf8)!), withName: key)
                }
            }
            for (index, value) in images.enumerated() {

                let imageData = value.jpegData(compressionQuality: 0.5)
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let str = formatter.string(from: Date())
                let fileName = str+"\(index)"+".jpg"

                // 以文件流格式上传
                // 批量上传与单张上传，后台语言为java或.net等
                multipartFormData.append(imageData!, withName: "fileupload", fileName: fileName, mimeType: "image/jpeg")
                // 单张上传，后台语言为PHP
                multipartFormData.append(imageData!, withName: "fileupload", fileName: fileName, mimeType: "image/jpeg")
//              // 批量上传，后台语言为PHP。 注意：此处服务器需要知道，前台传入的是一个图片数组
//                multipartFormData.append(imageData!, withName: "fileupload[\(index)]", fileName: fileName, mimeType: "image/jpeg")
            }
        },
                         to: urlString,
                         headers: ["":""],
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                                
                            case .success(let upload, _, _):
                                
                                upload.responseJSON { response in
                                    print("response = \(response)")
                                    let result = response.result
                                    let result2 = response.value
                                    if result.isSuccess {
                                        success(response.value)
                                    }else {
                                        print("~~~图片上传失败")
                                    }
                                }
                                
                            case .failure(let encodingError):
                                failture(encodingError)
                            }
        }
        )
    }
    
}
