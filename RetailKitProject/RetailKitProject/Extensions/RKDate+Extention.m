//
//  RKDate+Extention.m
//  RetailKitProject
//
//  Created by Sammy Chen on 9/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import "RKDate+Extention.h"


@implementation NSDate (Extenxion)


+ (NSDate *)getInternetDate {
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
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: netDate];
//    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    
    return netDate;
}


//+ (NSString *)currentTimeString {
//    
//    
//}

// 返回时间字符串
+ (NSString *)getInternetDateString {
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
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: netDate];
//    NSDate *localeDate = [netDate  dateByAddingTimeInterval: interval];
    
    
    // 网络时间
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"HH:mm:ss";
    NSString *string2 = [format stringFromDate:netDate];
    
    return string2;
}

#pragma mark ---- 将时间戳转换成时间

+ (NSString *)getTimeFromTimestamp:(NSTimeInterval)time {

    //将对象类型的时间转换为NSDate类型
    NSDate * myDate= [NSDate dateWithTimeIntervalSince1970:time];
    //设置时间格式
    NSDateFormatter * formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    //将时间转换为字符串
    NSString *timeStr = [formatter stringFromDate:myDate];
    return timeStr;

}


#pragma mark --- 将时间转换成时间戳

//- (NSString *)getTimestampFromTime{
//
//    NSDateFormatter *formatter = [[NSDateFormatteralloc] init];
//
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];// ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//
//    //设置时区,这个对于时间的处理有时很重要
//
//    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.
//
//    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
//
//    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
//
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//
//    [formatter setTimeZone:timeZone];
//
//    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
//
//    NSString *nowtimeStr = [formatter stringFromDate:datenow];//----------将nsdate按formatter格式转成nsstring
//
//    NSLog(@"%@", nowtimeStr);
//
//    // 时间转时间戳的方法:
//
//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date nowtimeIntervalSince1970]];
//
//    NSLog(@"timeSp:%@",timeSp);//时间戳的值
//
//    return timeSp;
//
//}
//


@end
