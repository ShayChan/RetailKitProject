//
//  RKDate+Extention.h
//  RetailKitProject
//
//  Created by Sammy Chen on 9/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Extenxion)

+ (NSDate *)getInternetDate;

+ (NSString *)getInternetDateString;

+ (NSString *)getTimeFromTimestamp:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
