//
//  String+Extension.swift
//  DawsonICMItem
//
//  Created by Sammy Chen on 13/11/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

import UIKit
import Alamofire
import Foundation


extension String {
    
    
    static public func stringFormatToDate(timeString:String,format:String) -> Date? {
        let dateFormatte = DateFormatter()
        dateFormatte.dateFormat = format
        return dateFormatte.date(from: timeString)
    }
    ///
    /// - Parameters:
    ///   - time: 时间戳（单位：s）
    ///   - format: 转换手的字符串格式
    /// - Returns: 转换后得到的字符串
    static public func formatTimeStamp(time:Int ,format:String) -> String {
        let timeInterval = TimeInterval(time)
        let date = Date.init(timeIntervalSince1970: timeInterval)
        let dateFormatte = DateFormatter()
        dateFormatte.dateFormat = format
        return dateFormatte.string(from: date)
    }
    
    static public func md5Str(str :String) -> String {
        
        let str1 = "geometry_84hdoEFVMe3".md5
        let str2 = str.md5
        let str3 = String(format: "%@%@", str1,str2)
        let str4 = str3.md5
        return str4
    }
    
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        let newData = NSData.init(data: data)
        CC_SHA1(newData.bytes, CC_LONG(data.count), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
         return output as String
    }
    
    // MD5加密
    var md5 : String{
     let str = self.cString(using: String.Encoding.utf8)
     let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
     let digestLen = Int(CC_MD5_DIGEST_LENGTH)
     let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
     CC_MD5(str!, strLen, result)
     let hash = NSMutableString()
     for i in 0 ..< digestLen {
     hash.appendFormat("%02x", result[i])
     }
        result.deinitialize(count: digestLen)
     return String(format: hash as String)
     }

    // JSONString转换为字典
    func getDictionaryFromJSONString(jsonString:String) ->[String : NSObject] {
     
        let jsonData:Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if dict != nil {
            return dict as! [String : NSObject]
        }
        return [String : NSObject]()
    }
    // JSONString转换为数组
    func getArrayFromJSONString(jsonString:String) ->NSArray{
        let jsonData:Data = jsonString.data(using: .utf8)!
        let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
        if array != nil {
            return array as! NSArray
        }
        return array as! NSArray
    }
    /**
        字典转换为JSONString
        - parameter dictionary: 字典参数
        - returns: JSONString
        */
       func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
           if (!JSONSerialization.isValidJSONObject(dictionary)) {
               print("无法解析出JSONString")
               return ""
           }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
           let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
           return JSONString! as String
           }
    //数组转json
    func getJSONStringFromArray(array:NSArray) -> String {
         
        if (!JSONSerialization.isValidJSONObject(array)) {
            print("无法解析出JSONString")
            return ""
        }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
    }
    
    func DS_widthWithString(font: UIFont, size: CGSize) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func DS_sizeWithString(font: UIFont, size: CGSize) -> CGSize {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: size.width, height: size.height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return rect.size
    }
    
    //MARK: - 以1开头的11位数字
    
    func isPhoneNum()->Bool {
        
        let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluate(with: self) == true)
            || (regextestcm.evaluate(with: self)  == true)
            || (regextestct.evaluate(with: self) == true)
            || (regextestcu.evaluate(with: self) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
//    // 监听网络状态
//    static func currentNetReachability() -> String {
//        let manager = NetworkReachabilityManager()
//        manager?.listener = { status in
//            var statusStr: String?
//            switch status {
//            case .unknown:
//                statusStr = "未识别的网络"
//                break
//            case .notReachable:
//                statusStr = "不可用的网络(未连接)"
//            case .reachable:
//                if (manager?.isReachableOnWWAN)! {
//                    statusStr = "2G,3G,4G...的网络"
//                } else if (manager?.isReachableOnEthernetOrWiFi)! {
//                    statusStr = "wifi的网络";
//                }
//                break
//            }
//            print("当前网络是 ~~~~~~~ \(statusStr as Any)")
//            print("当前网络是 ~~~~~~~ \(statusStr as Any)")
//            return statusStr
//        }
//        manager?.startListening()
//    }
}
 
//extension String{
//    func sha1() -> String{
//        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: true)!
//        var digest = [UInt8](unsafeUninitializedCapacity:Int(CC_SHA1_DIGEST_LENGTH),initializingWith:"")
//        let randomNumbers = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
//        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
//
//        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
//        for byte in digest{
//            output.appendFormat("%02x", byte)
//        }
//        return output as String
//    }
//}

//MARK: - sha1 加密




