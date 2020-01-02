//
//  CustomAnnotationView.m
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "CustomCalloutView.h"

#define kWidth  150.f
#define kHeight 60.f

#define kHoriMargin 5.f
#define kVertMargin 5.f

#define kPortraitWidth  50.f
#define kPortraitHeight 50.f

#define kCalloutWidth   200.0
#define kCalloutHeight  70.0

@interface CustomAnnotationView ()

@property (nonatomic, strong) UIImageView *portraitImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CustomAnnotationView

@synthesize calloutView;
@synthesize portraitImageView   = _portraitImageView;
@synthesize nameLabel           = _nameLabel;

#pragma mark - Handle Action

- (void)btnAction
{
    CLLocationCoordinate2D coorinate = [self.annotation coordinate];
    
    NSLog(@"coordinate = {%f, %f}", coorinate.latitude, coorinate.longitude);
}

#pragma mark - Override

- (NSString *)name
{
    return self.nameLabel.text;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (UIImage *)portrait
{
    return self.portraitImageView.image;
}

- (void)setPortrait:(UIImage *)portrait
{
    self.portraitImageView.image = portrait;
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            /* Construct custom callout. */
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(10, 10, 40, 40);
            [btn setTitle:@"Test" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
            [btn setBackgroundColor:[UIColor whiteColor]];
            [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
            
            [self.calloutView addSubview:btn];
            UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 100, 30)];
            name.backgroundColor = [UIColor clearColor];
            name.textColor = [UIColor whiteColor];
            name.text = @"Hello Amap!";
            [self.calloutView addSubview:name];
        }
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inside = [super pointInside:point withEvent:event];
    
    /* Points that lie outside the receiver’s bounds are never reported as hits,
     even if they actually lie within one of the receiver’s subviews.
     This can occur if the current view’s clipsToBounds property is set to NO and the affected subview extends beyond the view’s bounds.
     */
    
    if (!inside && self.selected)
    {
        inside = [self.calloutView pointInside:[self convertPoint:point toView:self.calloutView] withEvent:event];
    }
    
    return inside;
}

#pragma mark - Life Cycle

- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.bounds = CGRectMake(0.f, 0.f, kWidth, kHeight);
//        self.layer.masksToBounds = YES;
        
        


        
//        /* Create portrait image view and add to view hierarchy. */
//        self.portraitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kHoriMargin, kVertMargin, kPortraitWidth, kPortraitHeight)];
//        [self addSubview:self.portraitImageView];
//
//        /* Create name label. */
//        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitWidth + kHoriMargin,
//                                                                   kVertMargin,
//                                                                   kWidth - kPortraitWidth - kHoriMargin,
//                                                                   kHeight - 2 * kVertMargin)];
//        self.nameLabel.backgroundColor  = [UIColor clearColor];
//        self.nameLabel.textAlignment    = NSTextAlignmentCenter;
//        self.nameLabel.textColor        = [UIColor whiteColor];
//        self.nameLabel.font             = [UIFont systemFontOfSize:15.f];
//        [self addSubview:self.nameLabel];
        
        // 另外创建的label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(4, 4, kWidth-8, kHeight-20)];
        titleLabel.text = @"不在考勤范围内 >";
        titleLabel.textColor        = [UIColor colorWithRed:90/255.0 green:177/255.0 blue:211/255.0 alpha:1];
        titleLabel.font             = [UIFont systemFontOfSize:16.f];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLabel];

        titleLabel.layer.cornerRadius = 6;
        titleLabel.layer.masksToBounds = YES;
        // 阴影颜色
        titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
        // 阴影偏移量 默认为(0,3)
        titleLabel.layer.shadowOffset = CGSizeMake(0, 0);
        // 阴影透明度
        titleLabel.layer.shadowOpacity = 0.8;
        
        // 圆角和阴影并存
        CALayer *subLayer = [CALayer layer];
        subLayer.cornerRadius = 6;
        CGRect fixframe = titleLabel.frame;
        subLayer.frame= fixframe;
        subLayer.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
        subLayer.masksToBounds = NO;
        subLayer.shadowColor = [UIColor blackColor].CGColor;//shadowColor阴影颜色
        subLayer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移3，y向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        subLayer.shadowOpacity = 1;//阴影透明度，默认0
        subLayer.shadowRadius = 4;//阴影半径，默认3
        [self.layer insertSublayer:subLayer below:titleLabel.layer];
        
        // 倒三角图片
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"triangle"]];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        imgView.frame = CGRectMake(titleLabel.frame.size.width/2-10/2, CGRectGetMaxY(titleLabel.frame)-8, 20, 20);


    }
    
    return self;
}

@end
