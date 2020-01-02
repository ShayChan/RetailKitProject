//
//  LTSCalendarScrollView.h
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTSCalendarContentView.h"
#import "LTSCalendarWeekDayView.h"


typedef void(^RKProjectUpFreshBlock)(NSDictionary *dict);

typedef void(^RKProjectBlock)(void);


@interface LTSCalendarScrollView : UIScrollView

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) LTSCalendarContentView *calendarView;

@property (nonatomic,strong) UIColor *bgColor;

@property (nonatomic, copy) RKProjectBlock upBtnSrollBlock;

@property (nonatomic, copy) RKProjectUpFreshBlock refreshBlock;

// oc block属性 传递选中的日期
@property (copy, nonatomic) void (^seleteCurrentDate)(NSDate *currentDate);

@property (copy, nonatomic) void (^refreshCurrentTimeBlock)(NSString *currentTime);

@property (copy, nonatomic) void (^calendarScrollViewPhotoBlock)(NSString *photo);



- (void)scrollToSingleWeek;

- (void)scrollToAllWeek;



@end
