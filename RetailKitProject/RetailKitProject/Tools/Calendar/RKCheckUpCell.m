//
//  RKCheckUpCell.m
//  RetailKitProject
//
//  Created by Sammy Chen on 1/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import "RKCheckUpCell.h"
#import "Masonry.h"
#import "RKDate+Extention.h"
#import "RKString+Extension.h"


#define ScreenScale ([UIScreen mainScreen].bounds.size.width/375.0f)




@interface RKCheckUpCell()

@property (nonatomic, strong) UIButton *upBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *insideView;


@end

@implementation RKCheckUpCell {
    
//    NSTimer * _timer;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clockAction) userInfo:nil repeats:YES];

    }
    return self;
}

- (void)setModelDict:(NSDictionary *)modelDict {

    _modelDict = modelDict;
    NSString *time = [NSString stringWithFormat:@"%@",_modelDict[@"on_time"]];
    if (![NSString isEmptyString:time]) {
        _titleLabel.text = @"下班打卡";
    }
    else {
        _titleLabel.text = @"上班打卡";
    }
}

- (void)setCurrentTime:(NSString *)currentTime {
    _currentTime = currentTime;
    if (_currentTime.length>0) {
        _timeLabel.text = _currentTime;
    }else {
        // 为空
        NSDate *date = [NSDate date];
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        format.dateFormat = @"HH:mm:ss";
        NSString *string = [format stringFromDate:date];
        _timeLabel.text = string;
    }
}

//- (void)dealloc {
//    [_timer invalidate];
//    _timer = nil;
//}

- (void)upBtnClick {
    
    if (self.upBtnBlock) {
        self.upBtnBlock();
    }
}

- (void)initSubviews {
    
    [self.contentView addSubview:self.upBtn];
    [_upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(180*ScreenScale));
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(40*ScreenScale);
        make.bottom.equalTo(self.contentView).offset(-60*ScreenScale);
    }];
    [_upBtn addSubview:self.insideView];
    [_insideView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(140*ScreenScale));
        make.center.equalTo(_upBtn);
    }];
    [_insideView addSubview:self.titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_titleLabel.frame.size.height));
        make.centerX.equalTo(_insideView);
        make.bottom.equalTo(_insideView.mas_centerY).offset(-3);
    }];
    [_insideView addSubview:self.timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_titleLabel.frame.size.height));
        make.centerX.equalTo(_insideView);
        make.top.equalTo(_insideView.mas_centerY).offset(3);
    }];
}

- (UIButton *)upBtn {
    
    if (!_upBtn) {
        _upBtn = [[UIButton alloc] init];
        _upBtn.layer.masksToBounds = YES;
        _upBtn.layer.cornerRadius = 90*ScreenScale;
        _upBtn.backgroundColor = [UIColor colorWithRed:149/255.0 green:202/255.0 blue:245/255.0 alpha:1];
        [_upBtn addTarget:self action:@selector(upBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _upBtn;
}
- (UIView *)insideView {
    
    if (!_insideView) {
        _insideView = [[UIView alloc] init];
        _insideView.layer.masksToBounds = YES;
        _insideView.layer.cornerRadius = 70*ScreenScale;
        _insideView.backgroundColor = [UIColor colorWithRed:76/255.0 green:165/255.0 blue:251/255.0 alpha:1];
        _insideView.userInteractionEnabled = NO;
    }
    return _insideView;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"上班打卡";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18.f*ScreenScale];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
//        _timeLabel.text = @"09:00:02";
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:16.f*ScreenScale];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

@end
