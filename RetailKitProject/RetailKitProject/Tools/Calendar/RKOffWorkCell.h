//
//  RKOffWorkCell.h
//  RetailKitProject
//
//  Created by Sammy Chen on 31/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RKOffWorkCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *modelDict;

@property (copy, nonatomic) void (^offCellPhotoBlock)(NSString *photo);


@end

NS_ASSUME_NONNULL_END
