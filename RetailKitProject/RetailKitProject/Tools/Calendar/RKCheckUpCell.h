//
//  RKCheckUpCell.h
//  RetailKitProject
//
//  Created by Sammy Chen on 1/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

typedef void(^RKProjectBlock)(void);


@interface RKCheckUpCell : UITableViewCell

@property (nonatomic, copy) RKProjectBlock upBtnBlock;
// 传递过来的瞬时时间
@property (nonatomic, copy) NSString *currentTime;

@property (nonatomic, strong) NSDictionary *modelDict;


@end

NS_ASSUME_NONNULL_END
