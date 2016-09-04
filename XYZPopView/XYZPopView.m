//
//  XYZPopView.m
//  XYZPopView
//
//  Created by xieyingze on 16/8/7.
//  Copyright © 2016年 xieyingze. All rights reserved.
//

#import "XYZPopView.h"
#import "XYZPopCenterView.h"
#import "CALayer+SLPopAddition.h"
#import "UIImage+ColorImage.h"
#import <GPUImage/GPUImage.h>

#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface XYZPopView  ()

@property (nonatomic, strong)XYZPopCenterView *centerView;

@property (nonatomic, strong)UIImageView *imgViewBackGround;
@property (nonatomic, strong)GPUImageiOSBlurFilter *blurFilter;

@property (nonatomic, strong)UIButton *btnTouch;

@end

@implementation XYZPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    _blurFilter = [[GPUImageiOSBlurFilter alloc] init];
    _blurFilter.blurRadiusInPixels = 1.0;

    UIImage * image = [self convertViewToImage];
    UIImage *blurredSnapshotImage = [_blurFilter imageByFilteringImage:image];
    
    self.imgViewBackGround = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.imgViewBackGround.userInteractionEnabled = YES;
    [self.imgViewBackGround setImage:blurredSnapshotImage];
    self.imgViewBackGround.alpha = 0.00;
}

-(UIImage *)convertViewToImage
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContextWithOptions(rect.size,YES,0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *capturedScreen = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedScreen;
}

- (void)dismiss
{
    [self hideXYZPopView];
}

#pragma mark - configuration

#pragma mark - BaseMethods

- (void)showXYZPopView
{
    [self.imgViewBackGround addSubview:self.btnTouch];
    [self.btnTouch addSubview:self.centerView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.imgViewBackGround];
    
    _imgViewBackGround.alpha = 1.0;
    [_centerView.layer sl_basicWithName:kSLLayerOpacity to:@(1.0) duration:0.25 key:@"calendarView_opacity_animation" complete:nil];
    [_centerView.layer sl_springWithName:kSLLayerScaleXY
                                     from:[NSValue valueWithCGSize:CGSizeMake(0.3f, 0.3f)]
                                       to:[NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)]
                                   bounce:5 speed:10 key:@"calendarView_scaleXY_animation" complete:nil];
}

- (void)hideXYZPopView
{
    [UIView animateWithDuration:0.25 animations:^{
        _imgViewBackGround.alpha = 0.1;
    }];
    
    __weak typeof(self)weakSelf = self;
    [_centerView.layer sl_springWithName:kSLLayerScaleXY
                                    from:[NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)]
                                      to:[NSValue valueWithCGSize:CGSizeMake(0.6f, 0.6f)]
                                  bounce:0 speed:5 key:@"calendarView_scaleXY_animation" complete:nil];
    
    [_centerView.layer sl_basicWithName:kSLLayerOpacity to:@(0.01) duration:0.25 key:@"scaleXY" complete:^(id obj, BOOL finish) {
        if(finish){
            [weakSelf.imgViewBackGround removeFromSuperview];
            [weakSelf.btnTouch removeFromSuperview];
            [weakSelf.centerView removeFromSuperview];
        }
    }];
}

#pragma mark - Delegate


#pragma mark - EventResponse


#pragma mark - GettersAndSetters

- (XYZPopCenterView *)centerView
{
    if (_centerView == nil) {
        _centerView = [XYZPopCenterView initFromXIB];
        CGRect bounds = _centerView.bounds;
        bounds.size.width = KScreenWidth - 40;
        bounds.size.height = bounds.size.width;
        _centerView.bounds= bounds;
        _centerView.center = CGPointMake((KScreenWidth)/2, KScreenHeight/2);
    }
    return _centerView;
}

- (UIButton *)btnTouch
{
    if (_btnTouch == nil) {
        _btnTouch = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnTouch.frame = [UIScreen mainScreen].bounds;
        _btnTouch.backgroundColor = [UIColor clearColor];
        [_btnTouch addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnTouch;
}

@end
