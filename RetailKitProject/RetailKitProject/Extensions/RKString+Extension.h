//
//  RKString.h
//  RetailKitProject
//
//  Created by Sammy Chen on 18/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface NSString (Extenxion)

+ (NSString *)signStringWithDict:(NSDictionary *)dict;

+ (BOOL)isEmptyString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
