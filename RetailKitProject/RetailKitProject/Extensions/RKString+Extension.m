//
//  RKString.m
//  RetailKitProject
//
//  Created by Sammy Chen on 18/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import "RKString+Extension.h"
//#import "String+Extension.swift"
//#import <CommonCrypto/CommonCrypto.h>
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (Extenxion)



+ (BOOL)isEmptyString:(NSString *)string {

if (!string) {//等价于if(string == ni||string == NULL)
return YES;
}

if ([string isKindOfClass:[NSNull class]]) {//后台的数据可能是NSNull

return YES;

}

if (!string.length) {//字符串长度

return YES;

}

NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];

NSString *trimmedString = [string stringByTrimmingCharactersInSet:set];

if (!trimmedString.length) { // 存在一些空格或者换行

return YES;

}

return NO;

}


/*
 你的参数排序后：string(62) "ABC=987&BCD=111&DEF=222&bb=dfsffsdfsdf&nonce=456&timestamp=123"
 <br />生成的签名为：fe656d66909856a92e4e43b9035036fc
 */


+ (NSString *)signStringWithDict:(NSDictionary *)dict {
    
    NSMutableString *contentString  = [NSMutableString string];
    
        NSArray *keys = [dict allKeys];
        // key按字母顺序排序
        NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            return [obj1 compare:obj2 options:NSNumericSearch];
        }];
        // 拼接字符串
//        for (NSString *categoryId in sortedArray) {
            
//            if (![categoryId isEqualToString:@"sign"] && ![categoryId isEqualToString:@"signature"]) {
//                if([categoryId isEqualToString:@"biz_content"]){
//                    NSError *error = nil;
//                    NSDictionary* bizDict = [dict objectForKey:@"biz_content"];
//                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bizDict options:NSJSONWritingPrettyPrinted error: &error];
//                    NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
//                    NSString* jsonString1 = [[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding];
//                    NSString *jsonString2 = [jsonString1 stringByReplacingOccurrencesOfString:@" : " withString:@":"];
//                    [contentString appendFormat:@"biz_content=%@&",jsonString2];
//                }else{
//
//                    [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
//                }
//            }
            for (int i = 0; i<sortedArray.count; i++) {
                NSString *categoryId = sortedArray[i];
                if (![categoryId isEqualToString:@"sign"] && ![categoryId isEqualToString:@"signature"]) {
                    if([categoryId isEqualToString:@"biz_content"]){
                        NSError *error = nil;
                        NSDictionary* bizDict = [dict objectForKey:@"biz_content"];
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bizDict options:NSJSONWritingPrettyPrinted error: &error];
                        NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
                        NSString* jsonString1 = [[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding];
                        NSString *jsonString2 = [jsonString1 stringByReplacingOccurrencesOfString:@" : " withString:@":"];
                        [contentString appendFormat:@"biz_content=%@&",jsonString2];
                    }else{
                        if (i == sortedArray.count-1) {
                            [contentString appendFormat:@"%@=%@", categoryId, [dict valueForKey:categoryId]];
                        }else {
                            [contentString appendFormat:@"%@=%@&", categoryId, [dict valueForKey:categoryId]];
                        }
                    }
                }
            }
//        }
        //添加key字段
//        [contentString appendFormat:@"timestamp=%@", [dict objectForKey:@"timestamp"]];
        NSString *strUrl1 = [contentString stringByReplacingOccurrencesOfString:@"  " withString:@""];
    //    NSString *strUrl2 = [strUrl1 stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        NSString *strUrl3 = [strUrl1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];

    return strUrl3;
}

@end
