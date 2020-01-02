//
//  LTSCalendarScrollView.m
//  LTSCalendar
//
//  Created by 李棠松 on 2018/1/13.
//  Copyright © 2018年 leetangsong. All rights reserved.
//

#import "LTSCalendarScrollView.h"
#import "Masonry.h"
#import "RKCheckUpCell.h"
#import "RKGoWorkCell.h"
#import "RKUpNorCell.h"
#import "RKOffWorkCell.h"
#import "RKString+Extension.h"


#define WeakSelf __weak typeof(self) weakSelf = self
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface LTSCalendarScrollView()<UITableViewDelegate,UITableViewDataSource> {
    
//    NSMutableArray *rowArr;
}
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) NSMutableArray *rowArr;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,strong) UIView *midView;
@property (nonatomic,strong) UILabel *currentDayLabel;
// 打卡状态
@property (nonatomic,copy) NSString *checkStatu;
// 获取的瞬时时间
@property (nonatomic,copy) NSString *currentTime;
// 是否已经旋转 rotate
@property (nonatomic, assign) BOOL isRotate;

// 模型字典
@property (nonatomic,strong) NSDictionary *modelDict;


@end
@implementation LTSCalendarScrollView {
    
    NSInteger oldOffset; // 偏移量
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        WeakSelf;
        self.rowArr = [NSMutableArray arrayWithArray:@[@"1",@"2"]];
        [self initUI];
        // 刷新列表
        self.refreshBlock = ^ (NSDictionary *dict) {
            weakSelf.modelDict = dict;
            // 更新打卡状态
            weakSelf.checkStatu = @"success";
            [weakSelf.tableView reloadData];
        };
        
        // 当前日期 包括选中的日期
        self.seleteCurrentDate = ^(NSDate *currentDate) {
            
            NSString *date = [[weakSelf dateFormatter] stringFromDate:currentDate];
            weakSelf.currentDayLabel.text = date;
//            NSLog(@"~~~~~~~~~ 选中的日期 %@",date);
            
            // 选中日期 如果不是今天就刷新
            if (![weakSelf isToday:currentDate]) {
                weakSelf.checkStatu = @"success";
                [weakSelf.tableView reloadData];
            }else {
                // 当天之前 包括当天
                weakSelf.checkStatu = @"";
                [weakSelf.tableView reloadData];
            }
        };
        // 定时器
        self.refreshCurrentTimeBlock = ^ (NSString *currentTime){
            weakSelf.currentTime = currentTime;
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        };
    }
    return self;
}

- (BOOL)isToday:(NSDate *)seleteDate {
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime = date.timeIntervalSince1970;
    NSTimeInterval seletetTime = seleteDate.timeIntervalSince1970;
    return (currentTime - seletetTime) <= (24 * 60 * 60);
}

//// 接收通知
//- (void)refreshTableView: (NSNotification *)notification {
//    //处理消息
//    NSLog(@"~~~~~~~~~ 就是");
//}

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    self.backgroundColor = bgColor;
    self.tableView.backgroundColor = bgColor;
    self.line.backgroundColor = bgColor;
}

- (void)initUI {
    
    self.delegate = self;
    self.bounces = false;
    self.showsVerticalScrollIndicator = false;
    self.backgroundColor = [LTSCalendarAppearance share].scrollBgcolor;
    LTSCalendarContentView *calendarView = [[LTSCalendarContentView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [LTSCalendarAppearance share].weekDayHeight*[LTSCalendarAppearance share].weeksToDisplay)];
    NSDate *date = [NSDate date];
    calendarView.currentDate = date;
    [self addSubview:calendarView];
    self.calendarView = calendarView;
//    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame),0.5)];
    
    // 添加一条中间view
    _midView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(calendarView.frame), CGRectGetWidth(self.frame), 60)];
    _midView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_midView];
    UIImage *img = [UIImage imageNamed:@"calender_down"];
    self.imgView = [[UIImageView alloc] initWithImage:img];
    [_midView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_midView);
        make.centerX.equalTo(_midView);
        make.width.equalTo(@(img.size.width));
        make.height.equalTo(@(img.size.height));
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_midView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(2);
        make.left.right.equalTo(_midView);
        make.height.equalTo(@(8));
    }];
    _currentDayLabel = [[UILabel alloc] init];
    _currentDayLabel.textAlignment = NSTextAlignmentCenter;
    _currentDayLabel.backgroundColor = [UIColor whiteColor];
    [_midView addSubview:_currentDayLabel];
    [_currentDayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.equalTo(_midView);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_midView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-CGRectGetMaxY(_midView.frame))];

    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
//    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
//    self.tableView.scrollEnabled = [LTSCalendarAppearance share].isShowSingleWeek;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:self.tableView];
    self.line.backgroundColor = self.backgroundColor;
    [self addSubview:self.line];
    [LTSCalendarAppearance share].isShowSingleWeek ? [self scrollToSingleWeek]:[self scrollToAllWeek];
}
// 格式化时间
- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    if(!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        //自定义星期显示
        dateFormatter.weekdaySymbols = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
        dateFormatter.dateFormat = @"MM月dd日 EEEE";
    }
    return dateFormatter;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rowArr.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *on_photo = self.modelDict[@"on_photo"];
    NSString *off_photo = self.modelDict[@"off_photo"];

    
    if (![NSString isEmptyString:on_photo] && ![NSString isEmptyString:off_photo]) {
        // 上下班都打了卡
        if (indexPath.row==0) {
            
            static NSString *cellnew = @"RKGoWorkCell";
            RKGoWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
            if (cell == nil) {
                cell  = [[RKGoWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            cell.modelDict = self.modelDict;
            cell.goCellPhotoBlock = ^(NSString * _Nonnull photo) {
                // 显示在控制器中
                if (self.calendarScrollViewPhotoBlock) {
                    self.calendarScrollViewPhotoBlock(photo);
                }
            };
            return cell;
        }else if (indexPath.row==1) {
            static NSString *cellnew = @"RKOffWorkCell";
            RKOffWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
            if (cell == nil) {
                cell  = [[RKOffWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            cell.offCellPhotoBlock = ^(NSString * _Nonnull photo) {
                // 显示在控制器中
                if (self.calendarScrollViewPhotoBlock) {
                    self.calendarScrollViewPhotoBlock(photo);
                }
            };
            cell.modelDict = self.modelDict;

            return cell;
        }
    }
    else if (![NSString isEmptyString:on_photo]) {
        // 只打了上班卡
        if (indexPath.row==0) {

            static NSString *cellnew = @"RKGoWorkCell";
            RKGoWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
            if (cell == nil) {
                cell  = [[RKGoWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            cell.modelDict = self.modelDict;
            cell.goCellPhotoBlock = ^(NSString * _Nonnull photo) {
                // 显示在控制器中
                if (self.calendarScrollViewPhotoBlock) {
                    self.calendarScrollViewPhotoBlock(photo);
                }
            };
            return cell;
        }else if (indexPath.row==1) {
            static NSString *cellnew = @"RKCheckUpCell";
            RKCheckUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
            if (cell == nil) {
                cell  = [[RKCheckUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            }
            cell.upBtnBlock = ^ {
                if (self.upBtnSrollBlock) {
                    self.upBtnSrollBlock();
                }
            };
            cell.modelDict = self.modelDict;

            cell.currentTime = self.currentTime;
            return cell;
        }
    }

    // 没有打卡
    if (indexPath.row==0) {
        static NSString *cellnew = @"RKUpNorCell";
        RKUpNorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
        if (cell == nil) {
            cell  = [[RKUpNorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        return cell;
    }else if (indexPath.row==1) {
        static NSString *cellnew = @"RKCheckUpCell";
        RKCheckUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
        if (cell == nil) {
            cell  = [[RKCheckUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        cell.upBtnBlock = ^ {
            if (self.upBtnSrollBlock) {
                self.upBtnSrollBlock();
            }
        };
        cell.modelDict = self.modelDict;
        cell.currentTime = self.currentTime;
        return cell;
    }
    return [UITableViewCell new];
    
//    if (![self.checkStatu isEqualToString:@"success"]) {
//        // 没有打卡
//        if (indexPath.row==0) {
//            static NSString *cellnew = @"RKUpNorCell";
//            RKUpNorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
//            if (cell == nil) {
//                cell  = [[RKUpNorCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            }
//            return cell;
//        }else if (indexPath.row==1) {
//            static NSString *cellnew = @"RKCheckUpCell";
//            RKCheckUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
//            if (cell == nil) {
//                cell  = [[RKCheckUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            }
//            cell.upBtnBlock = ^ {
//                if (self.upBtnSrollBlock) {
//                    self.upBtnSrollBlock();
//                }
//            };
//            cell.currentTime = self.currentTime;
//            return cell;
//        }
//    }
//    else {  // RKOffWorkCell
//
//        // 已经上班打卡
//        if (indexPath.row==0) {
//
//            static NSString *cellnew = @"RKGoWorkCell";
//            RKGoWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
//            if (cell == nil) {
//                cell  = [[RKGoWorkCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            }
//            return cell;
//        }else if (indexPath.row==1) {
//            static NSString *cellnew = @"RKCheckUpCell";
//            RKCheckUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellnew];
//            if (cell == nil) {
//                cell  = [[RKCheckUpCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellnew];
//                cell.selectionStyle = UITableViewCellSelectionStyleNone;
//                cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
//            }
//            cell.upBtnBlock = ^ {
//                if (self.upBtnSrollBlock) {
//                    self.upBtnSrollBlock();
//                }
//            };
//            cell.currentTime = self.currentTime;
//            return cell;
//        }
//    }
//    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"~~~~~~~~~~~ %f",offsetY);
    
    if (scrollView != self) {
        return;
    }
  
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    ///日历需要滑动的距离
    CGFloat calendarCountDistance = self.calendarView.singleWeekOffsetY;
    
    CGFloat scale = calendarCountDistance/tableCountDistance;
    
    CGRect calendarFrame = self.calendarView.frame;
    self.calendarView.maskView.alpha = offsetY/tableCountDistance;
    self.calendarView.maskView.hidden = false;
    calendarFrame.origin.y = offsetY-offsetY*scale;
    if(ABS(offsetY) >= tableCountDistance) {
//        self.tableView.scrollEnabled = true;
        
        self.calendarView.maskView.hidden = true;
        //为了使滑动更加顺滑，这部操作根据 手指的操作去设置
         [self.calendarView setSingleWeek:true];
        
    }else {
        
//        self.tableView.scrollEnabled = false;
        if ([LTSCalendarAppearance share].isShowSingleWeek) {
            [self.calendarView setSingleWeek:false];
        }
    }
    CGFloat scollH = CGRectGetHeight(self.frame); // 681
//    CGFloat calenH = CGRectGetHeight(self.calendarView.frame); // 300
    CGFloat midViewH = CGRectGetHeight(self.midView.frame); // 60
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = scollH-midViewH-50;
    self.tableView.frame = tableFrame; 
//    self.bounces = false;
    
    if (offsetY>=250) {
        if (self.isRotate) {
            // 还原
            self.imgView.transform = CGAffineTransformIdentity;
            // 记录旋转状态
            self.isRotate = NO;
        }
    }
    if (offsetY<=0) {
//        self.bounces = false;
        calendarFrame.origin.y = offsetY;
        tableFrame.size.height = scollH-midViewH-50-250;
        self.tableView.frame = tableFrame;
//        self.scrollEnabled = NO;
        // 如果已经旋转就不需要旋转
        if (!self.isRotate) {
            // 旋转向上
            self.imgView.transform = CGAffineTransformRotate(self.imgView.transform, M_PI);//旋转180
            // 记录旋转状态
            self.isRotate = YES;
        }
    }
    self.calendarView.frame = calendarFrame;
    
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    if ( appearce.isShowSingleWeek) {
        if (self.contentOffset.y != tableCountDistance) {
            return  nil;
        }
    }
    if ( !appearce.isShowSingleWeek) {
        if (self.contentOffset.y != 0 ) {
            return  nil;
        }
    }
    return  [super hitTest:point withEvent:event];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);

    if (scrollView.contentOffset.y>=tableCountDistance) {
        [self.calendarView setSingleWeek:true];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self != scrollView) {
        return;
    }
   
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    if (point.y<=0) {
        [self scrollToSingleWeek];
    }
    if (scrollView.contentOffset.y<tableCountDistance-20&&point.y>0) {
        [self scrollToAllWeek];
    }
}

// 手指触摸完
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self != scrollView) {
        return;
    }
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    //point.y<0向上
    CGPoint point =  [scrollView.panGestureRecognizer translationInView:scrollView];
    
    
    if (point.y<=0) {
        if (scrollView.contentOffset.y>=20) {
            if (scrollView.contentOffset.y>=tableCountDistance) {
                [self.calendarView setSingleWeek:true];
            }
            [self scrollToSingleWeek];
        }else{
            [self scrollToAllWeek];
        }
    }else{
        if (scrollView.contentOffset.y<tableCountDistance-20) {
            [self scrollToAllWeek];
        }else{
            [self scrollToSingleWeek];
        }
    }
    
    if (scrollView.contentOffset.y >oldOffset) {
        NSLog(@"~~~~~ 向上滑动");
        LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
        ///表需要滑动的距离
        CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
        [self setContentOffset:CGPointMake(0, tableCountDistance) animated:true];

    }else{
        NSLog(@"~~~~~ 向下滑动");
        [self setContentOffset:CGPointMake(0, 0) animated:true];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
     [self.calendarView setUpVisualRegion];
    oldOffset  = scrollView.contentOffset.y;
}


- (void)scrollToSingleWeek {
    
    LTSCalendarAppearance *appearce =  [LTSCalendarAppearance share];
    ///表需要滑动的距离
    CGFloat tableCountDistance = appearce.weekDayHeight*(appearce.weeksToDisplay-1);
    [self setContentOffset:CGPointMake(0, tableCountDistance) animated:true];
}

- (void)scrollToAllWeek {
    [self setContentOffset:CGPointMake(0, 0) animated:true];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.contentSize = CGSizeMake(0, CGRectGetHeight(self.frame)+[LTSCalendarAppearance share].weekDayHeight*([LTSCalendarAppearance share].weeksToDisplay-1));
}

@end
