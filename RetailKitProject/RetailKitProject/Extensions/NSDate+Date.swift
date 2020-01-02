//
//  NSDate+Date.swift
//  BHJPickerView
//
//  Created by 白华君 on 2018/5/17.
//  Copyright © 2018年 baihuajun. All rights reserved.
//


import UIKit


extension Date {
    
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }

    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    // MARK: - 获取时间字符串
    /// 获取时间字符串
    ///
    /// - Parameter fromDate: 时间
    /// - Returns: 返回字符串
    func dateStringWithDate(_ fromDate : Date) -> String{
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: fromDate)
        return date.components(separatedBy: " ").first!
    }
    
    func dateFormatterWeekWithDate(_ fromDate : Date) -> String{
        
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = "yyyy-MM-dd EEEE"
        formatter.weekdaySymbols = ["周日", "周一", "周二", "周三", "周四", "周五", "周六"]
        let dateStr = formatter.string(from: fromDate)
        return dateStr
    }
    
    /// 获取时间差
    ///
    /// - Parameter fromDate: 开始时间
    /// - Returns: 返回时间差
    func daltaFrom(_ fromDate : Date)  -> DateComponents{
        
        /// 获取当前日历
        let calendar = Calendar.current
        let components : Set<Calendar.Component> = [.year, .month,.day, .hour, .minute, .second]
        return calendar.dateComponents(components, from: self)
    }
    
    /// 是否是同一年
    ///
    /// - Returns: ture or false
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        let currendarYear = calendar.component(.year, from: Date())
        let selfYear =  calendar.component(.year, from: self)
        return currendarYear == selfYear
    }
    
    /// 是否是今天的时间
    ///
    /// - Returns: Bool
    func isToday() -> Bool{
        
        let currentTime = Date().timeIntervalSince1970
        let selfTime = self.timeIntervalSince1970
        return (currentTime - selfTime) <= (24 * 60 * 60)
    }
    
    /// 是否是昨天的时间
    ///
    /// - Returns: Bool
    func isYesToday() -> Bool {
        
        let currentTime = Date().timeIntervalSince1970
        
        let selfTime = self.timeIntervalSince1970
        
        return (currentTime - selfTime) > (24 * 60 * 60)
    }
}

extension Date {
    
    /*
     
    - (NSDate *)getInternetDate
    {
         NSString *urlString = @"http://m.baidu.com";
         urlString = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
         NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
         [request setURL:[NSURL URLWithString: urlString]];
         [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
         [request setTimeoutInterval: 2];
         [request setHTTPShouldHandleCookies:FALSE];
         [request setHTTPMethod:@"GET"];
          NSHTTPURLResponse *response;
         [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
     
         NSString *date = [[response allHeaderFields] objectForKey:@"Date"];
         date = [date substringFromIndex:5];
         date = [date substringToIndex:[date length]-4];
         NSDateFormatter *dMatter = [[NSDateFormatter alloc] init];
         dMatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
         [dMatter setDateFormat:@"dd MMM yyyy HH:mm:ss"];
    NSDate *netDate = [[dMatter dateFromString:date] dateByAddingTimeInterval:60*60*8];
        
        NSTimeZone *zone = [NSTimeZone systemTimeZone];
        NSInteger interval = [zone secondsFromGMTForDate: netDate];
        NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
        return localeDate;
    }
     
     */
//
//    func getInternetDate() -> NSDate {
//
//        var urlString = "http://m.baidu.com"
//        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let request = NSMutableURLRequest.init()
//        request.url = URL(string: urlString)
//        request.cachePolicy = .reloadIgnoringCacheData
//        request.timeoutInterval = 2
//        request.httpShouldHandleCookies = false
//        request.httpMethod = "GET"
////        let response = urlcon
//
//
//        let response = try NSURLSession.dataW
//
////        let transactionRecipsting:String = reciptaData.base64EncodedString(options: .endLineWithLineFeed)
////
////        self.checkAppstorePayResultWithBase64String(transactionRecipsting)
//
//
////        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: urlString)!) { (data, response, error) in
////
////            if let httpresponse = response as? HTTPURLResponse {
////                var dateString = httpresponse.allHeaderFields["Date"] as? String
////                dateString = dateString?.substring(from: (dateString?.characters.index((dateString?.startIndex)!, offsetBy: 5))!)
////                dateString = dateString?.substring(to: (dateString?.charac
////                    ters.index((dateString?.endIndex)!, offsetBy: -4))!)
////                print(dateString as Any)
////
////                let datefmt = DateFormatter()
////                datefmt.locale = Locale(identifier: "en_US")
////                datefmt.dateFormat = "HH:mm:ss"
////
////                let date = datefmt.date(from: dateString!)?.addingTimeInterval(60*60*8)
////                print(date as Any)
////                let zone = NSTimeZone.system
////                let inter = zone.secondsFromGMT(for: date!)
////                let locadate = date?.addingTimeInterval(TimeInterval(inter))
////                print(locadate as Any)
////            }
////        }
////        task.resume()
//    }
    
    
    
    func getInternetDate() ->NSDate {

        let urlString = "http://m.baidu.com"
        let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if let httpresponse = response as? HTTPURLResponse {
                let dateString = httpresponse.allHeaderFields["Date"] as? String
                print(dateString as Any)
                let datefmt = DateFormatter()
                datefmt.locale = Locale(identifier: "en_US")
                datefmt.dateFormat = "dd MMM yyyy HH:mm:ss"
                let date = datefmt.date(from: dateString!)?.addingTimeInterval(60*60*8)
                print(date as Any)
                let zone = NSTimeZone.system
                let inter = zone.secondsFromGMT(for: date!)
                let locadate = date?.addingTimeInterval(TimeInterval(inter))
                print(locadate as Any)
//                return locadate
            }
//            return NSDate.init()
        }
        task.resume()
        return NSDate.init()
    }
}
