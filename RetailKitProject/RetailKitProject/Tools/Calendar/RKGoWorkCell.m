//
//  RKGoWorkCell.m
//  RetailKitProject
//
//  Created by Sammy Chen on 1/12/2019.
//  Copyright © 2019 Geometry. All rights reserved.
//

#import "RKGoWorkCell.h"
#import "Masonry.h"
#import "RKDate+Extention.h"



#define ScreenScale ([UIScreen mainScreen].bounds.size.width/375.0f)
#define detailTextColor [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];


@interface RKGoWorkCell()

@property (nonatomic, strong) UIView *upCirView;
@property (nonatomic, strong) UILabel *goWorkLabel;
@property (nonatomic, strong) UILabel *checkLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UILabel *authLabel;
// 已经拍照btn
@property (nonatomic, strong) UIButton *didTakePhotoBtn;
// 查看备注 Remarks
@property (nonatomic, strong) UIButton *remarksBtn;

@property (nonatomic, strong) UILabel *downWorkLabel;
@property (nonatomic, strong) UIView *downCirView;
//@property (nonatomic, strong) UIButton *upBtn;
//@property (nonatomic, strong) UILabel *titleLabel;
//@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) UIView *insideView;

@property (nonatomic, copy) NSString *photo;



@end

@implementation RKGoWorkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle: style reuseIdentifier:reuseIdentifier]) {
        [self initSubviews];
    }
    return self;
}

- (void)setModelDict:(NSDictionary *)modelDict {
    
    _modelDict = modelDict;
    
    NSString *time = [NSString stringWithFormat:@"%@",_modelDict[@"on_time"]];
    _checkLabel.text = [NSString stringWithFormat:@"打卡时间：%@",[NSDate getTimeFromTimestamp:time.integerValue]];
    
    _locationLabel.text = [NSString stringWithFormat:@"%@",_modelDict[@"on_address"]];
    
    _photo = [NSString stringWithFormat:@"%@",_modelDict[@"on_photo"]];
    
    
}

- (void)didTakePhotoBtnClick {
    NSLog(@"~~~~ 已拍照");
    
    if (self.goCellPhotoBlock) {
        self.goCellPhotoBlock(_photo);
    }
}
- (void)remarksBtnClick {
    NSLog(@"~~~~ 查看备注");
    
//    if (self.upBtnBlock) {
//        self.upBtnBlock();
//    }
    
}

- (void)initSubviews {
    
    self.upCirView = [[UIView alloc] init];
    _upCirView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
    _upCirView.layer.masksToBounds = YES;
    _upCirView.layer.cornerRadius = 10*ScreenScale;
    [self.contentView addSubview:_upCirView];
    [_upCirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20*ScreenScale));
        make.top.equalTo(self.contentView).offset(60*ScreenScale);
        make.left.equalTo(self.contentView).offset(36);
    }];
    [self.contentView addSubview:self.goWorkLabel];
    [_goWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(self.upCirView.mas_right).offset(30);
        make.centerY.equalTo(self.upCirView);
    }];
    [self.contentView addSubview:self.checkLabel];
    [_checkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(self.goWorkLabel);
        make.top.equalTo(self.goWorkLabel.mas_bottom).offset(30*ScreenScale);
    }];
    UIImageView *locaImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location_cell"]];
    locaImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:locaImgView];
    [locaImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(self.goWorkLabel);
        make.top.equalTo(self.checkLabel.mas_bottom).offset(18);
    }];
    [self.contentView addSubview:self.locationLabel];
    [_locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(locaImgView.mas_right).offset(16);
        make.centerY.equalTo(locaImgView);
        make.right.equalTo(self.contentView).offset(-12);

    }];
    UIImageView *authImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"renzheng_check"]];
    authImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:authImgView];
    [authImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.left.equalTo(self.goWorkLabel);
        make.top.equalTo(locaImgView.mas_bottom).offset(18);
    }];
    [self.contentView addSubview:self.authLabel];
    [_authLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(authImgView.mas_right).offset(16);
        make.centerY.equalTo(authImgView);
    }];
    [self.contentView addSubview:self.didTakePhotoBtn];
    [_didTakePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.didTakePhotoBtn.frame.size.height+40));
        make.width.equalTo(@(self.didTakePhotoBtn.frame.size.width));
        make.left.equalTo(self.authLabel.mas_right);
        make.centerY.equalTo(self.authLabel);
    }];
    [self.contentView addSubview:self.remarksBtn];
    [_remarksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.remarksBtn.frame.size.width));
        make.height.equalTo(@(self.remarksBtn.frame.size.height));
        make.left.equalTo(self.goWorkLabel);
        make.top.equalTo(authImgView.mas_bottom).offset(18);
    }];
    [self.contentView addSubview:self.downWorkLabel];
    [_downWorkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.goWorkLabel.frame.size.height));
        make.left.equalTo(self.goWorkLabel);
        make.top.equalTo(self.remarksBtn.mas_bottom).offset(30*ScreenScale);
        make.bottom.equalTo(self.contentView).offset(-30*ScreenScale);
    }];
    _downCirView = [[UIView alloc] init];
    _downCirView.backgroundColor = [UIColor colorWithRed:149/255.0 green:202/255.0 blue:245/255.0 alpha:1];
    _downCirView.layer.masksToBounds = YES;
    _downCirView.layer.cornerRadius = 10*ScreenScale;
    [self.contentView addSubview:_downCirView];
    [_downCirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20*ScreenScale));
        make.centerY.equalTo(self.downWorkLabel);
        make.centerX.equalTo(self.upCirView);
    }];
    // 内圆
    UIView *inCirView = [[UIView alloc] init];
    inCirView.backgroundColor = [UIColor colorWithRed:76/255.0 green:165/255.0 blue:251/255.0 alpha:1];
    inCirView.layer.masksToBounds = YES;
    inCirView.layer.cornerRadius = 8*ScreenScale;
    [self.contentView addSubview:inCirView];
    [inCirView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(16*ScreenScale));
        make.centerY.equalTo(self.downWorkLabel);
        make.centerX.equalTo(self.upCirView);
    }];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.upCirView.mas_bottom);
        make.centerX.equalTo(self.upCirView);
        make.width.equalTo(@(1));
        make.bottom.equalTo(self.downCirView.mas_top);
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
- (UILabel *)checkLabel {
    
    if (!_checkLabel) {
        _checkLabel = [[UILabel alloc] init];
        _checkLabel.text = @"打卡时间：08:30";
        _checkLabel.textColor = [UIColor blackColor];
        _checkLabel.font = [UIFont systemFontOfSize:18.f*ScreenScale weight:UIFontWeightBold];
        [_checkLabel sizeToFit];
    }
    return _checkLabel;
}
- (UILabel *)locationLabel {
    
    if (!_locationLabel) {
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.text = @"广州金海湾";
        _locationLabel.textColor = detailTextColor;
        _locationLabel.font = [UIFont systemFontOfSize:16.f*ScreenScale];
        _locationLabel.numberOfLines = 0;
//        [_locationLabel sizeToFit];
    }
    return _locationLabel;
}
- (UILabel *)authLabel {
    
    if (!_authLabel) {
        _authLabel = [[UILabel alloc] init];
        _authLabel.text = @"身份验证：";
        _authLabel.textColor = detailTextColor;
        _authLabel.font = [UIFont systemFontOfSize:16.f*ScreenScale];
        [_authLabel sizeToFit];
    }
    return _authLabel;
}
- (UIButton *)didTakePhotoBtn {

    if (!_didTakePhotoBtn) {
        _didTakePhotoBtn = [[UIButton alloc] init];
        [_didTakePhotoBtn setTitleColor:[UIColor colorWithRed:76/255.0 green:165/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
        [_didTakePhotoBtn setTitle:@"已拍照" forState:UIControlStateNormal];
        _didTakePhotoBtn.titleLabel.font = [UIFont systemFontOfSize:16.f*ScreenScale];
//        _didTakePhotoBtn.layer.masksToBounds = YES;
//        _didTakePhotoBtn.layer.cornerRadius = 90*ScreenScale;
//        _didTakePhotoBtn.backgroundColor = detailTextColor;
        [_didTakePhotoBtn addTarget:self action:@selector(didTakePhotoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_didTakePhotoBtn sizeToFit];
    }
    return _didTakePhotoBtn;
}
- (UIButton *)remarksBtn {

    if (!_remarksBtn) {
        _remarksBtn = [[UIButton alloc] init];
        [_remarksBtn setTitleColor:[UIColor colorWithRed:76/255.0 green:165/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
        [_remarksBtn setTitle:@"查看备注 >" forState:UIControlStateNormal];
        _remarksBtn.titleLabel.font = [UIFont systemFontOfSize:18.f*ScreenScale];
        [_remarksBtn addTarget:self action:@selector(remarksBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_remarksBtn sizeToFit];
    }
    return _remarksBtn;
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
