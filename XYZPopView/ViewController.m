//
//  ViewController.m
//  XYZPopView
//
//  Created by xieyingze on 16/8/7.
//  Copyright © 2016年 xieyingze. All rights reserved.
//

#import "ViewController.h"
#import "CALayer+SLPopAddition.h"
#import "UIView+Extension.h"
#import "XYZPopView.h"

#define KScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

//@property (nonatomic, strong)UIView *viewComment;
@property (nonatomic, strong) UIVisualEffectView *viewComment;
@property (nonatomic, assign)BOOL isShowCommentView;

@property (nonatomic, strong)XYZPopView *popView;

@end

@implementation ViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self configuration];
}

#pragma mark - configuration

- (void)configuration
{
    self.title = @"测试";
    
    self.isShowCommentView = NO;
    
    [self setupRightBarItem];
}

- (void)setupSearchView
{
}

- (void)setupRightBarItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(toShowCommentView)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)toShowCommentView
{
    [self.popView showXYZPopView];
    
#if 0
    if (!_isShowCommentView) {
        [[UIApplication sharedApplication].keyWindow addSubview:self.viewComment];
        [_viewComment.layer sl_basicWithName:kSLLayerOpacity to:@(0.8) duration:0.25 key:@"calendarView_opacity_animation" complete:nil];
        [_viewComment.layer sl_springWithName:kSLLayerScaleXY
                                               from:[NSValue valueWithCGSize:CGSizeMake(0.3f, 0.3f)]
                                                 to:[NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)]
                                             bounce:5 speed:10 key:@"calendarView_scaleXY_animation" complete:nil];
        _isShowCommentView = YES;
    }else{
        __weak typeof(self)weakSelf = self;
        [_viewComment.layer sl_basicWithName:kSLLayerOpacity to:@(0.01) duration:0.25 key:@"scaleXY" complete:^(id obj, BOOL finish) {
            if(finish){}
        }];
        [_viewComment.layer sl_springWithName:kSLLayerScaleXY
                                               from:[NSValue valueWithCGSize:CGSizeMake(1.0f, 1.0f)]
                                                 to:[NSValue valueWithCGSize:CGSizeMake(0.6f, 0.6f)]
                                             bounce:0 speed:5 key:@"calendarView_scaleXY_animation" complete:nil];
        _isShowCommentView = NO;
    }
#endif
}

#pragma mark - BaseMethods


#pragma mark - Delegate


#pragma mark - EventResponse


#pragma mark - GettersAndSetters

#if 0
- (UIVisualEffectView *)viewComment
{
    if (_viewComment == nil) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.viewComment = [[UIVisualEffectView alloc] initWithEffect:blur];
        self.viewComment.frame = [UIScreen mainScreen].bounds;
//        self.viewComment.frame = CGRectMake((KScreenWidth - 200)/2, (KScreenHeight - 120)/2, 200, 120);
        self.viewComment.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.01];
//        self.viewComment.alpha = 0.01;
        [[UIApplication sharedApplication].keyWindow addSubview:self.viewComment];
    }
    return _viewComment;
}
#endif

- (XYZPopView *)popView
{
    if (_popView == nil) {
        _popView = [[XYZPopView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _popView;
}

@end
