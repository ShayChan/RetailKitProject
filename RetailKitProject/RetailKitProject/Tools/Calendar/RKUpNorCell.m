//
//  RKUpNorCell.m
//  RetailKitProject
//
//  Created by Sammy Chen on 2/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import "RKUpNorCell.h"
#import "Masonry.h"


#define ScreenScale ([UIScreen mainScreen].bounds.size.width/375.0f)
#define detailTextColor [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];

@interface RKUpNorCell()

@property (nonatomic, strong) UIView *upCirView;
@property (nonatomic, strong) UILabel *goWorkLabel;
@property (nonatomic, strong) UILabel *downWorkLabel;
@property (nonatomic, strong) UIView *downCirView;


@end

@implementation RKUpNorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {

    _upCirView = [[UIView alloc] init];
    _upCirView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
    _upCirView.layer.masksToBounds = YES;
    _upCirView.layer.cornerRadius = 10*ScreenScale;
    [self.contentView addSubview:_upCirView];
    [_upCirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20*ScreenScale));
        make.top.equalTo(self.contentView).offset(60);
        make.left.equalTo(self.contentView).offset(36);
    }];
    [self.contentView addSubview:self.goWorkLabel];
    [_goWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(self.upCirView.mas_right).offset(30);
        make.centerY.equalTo(self.upCirView);
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upCirView.mas_bottom);
        make.height.equalTo(@(80));
        make.centerX.equalTo(self.upCirView);
        make.width.equalTo(@(1));
    }];
    _downCirView = [[UIView alloc] init];
    _downCirView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
    _downCirView.layer.masksToBounds = YES;
    _downCirView.layer.cornerRadius = 10*ScreenScale;
    [self.contentView addSubview:_downCirView];
    [_downCirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20*ScreenScale));
        make.top.equalTo(lineView.mas_bottom);
        make.centerX.equalTo(lineView);
        make.bottom.equalTo(self.contentView).offset(-30*ScreenScale);
    }];
    [self.contentView addSubview:self.downWorkLabel];
    [_downWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(self.upCirView.mas_right).offset(30);
        make.centerY.equalTo(self.downCirView);
    }];
}


- (UILabel *)goWorkLabel {
    
    if (!_goWorkLabel) {
        _goWorkLabel = [[UILabel alloc] init];
        _goWorkLabel.text = @"上班（时间09:00）";
        _goWorkLabel.textColor = detailTextColor;
        _goWorkLabel.font = [UIFont systemFontOfSize:18.f*ScreenScale];
        [_goWorkLabel sizeToFit];
    }
    return _goWorkLabel;
}

- (UILabel *)downWorkLabel {
    
    if (!_downWorkLabel) {
        _downWorkLabel = [[UILabel alloc] init];
        _downWorkLabel.text = @"下班（时间18:00）";
        _downWorkLabel.textColor = detailTextColor;
        _downWorkLabel.font = [UIFont systemFontOfSize:18.f*ScreenScale];
        [_downWorkLabel sizeToFit];
    }
    return _downWorkLabel;
}

@end
