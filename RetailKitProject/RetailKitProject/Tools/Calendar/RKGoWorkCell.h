//
//  RKGoWorkCell.h
//  RetailKitProject
//
//  Created by Sammy Chen on 1/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKGoWorkCell : UITableViewCell


@property (nonatomic, strong) NSDictionary *modelDict;


@property (copy, nonatomic) void (^goCellPhotoBlock)(NSString *photo);



@end

NS_ASSUME_NONNULL_END
