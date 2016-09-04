//
//  CALayer+SLPopAddition.m
//  ZPAreaPickerView
//
//  Created by 赵鹏 on 16/2/18.
//  Copyright © 2016年 赵鹏. All rights reserved.
//
#import "CALayer+SLPopAddition.h"
#import "POP.h"

NSString * const kSLLayerBackgroundColor        = @"backgroundColor";
NSString * const kSLLayerBounds                 = @"bounds";
NSString * const kSLLayerCornerRadius           = @"cornerRadius";
NSString * const kSLLayerBorderWidth            = @"borderWidth";
NSString * const kSLLayerBorderColor            = @"borderColor";
NSString * const kSLLayerOpacity                = @"opacity";
NSString * const kSLLayerPosition               = @"position";
NSString * const kSLLayerPositionX              = @"positionX";
NSString * const kSLLayerPositionY              = @"positionY";
NSString * const kSLLayerRotation               = @"rotation";
NSString * const kSLLayerRotationX              = @"rotationX";
NSString * const kSLLayerRotationY              = @"rotationY";
NSString * const kSLLayerScaleX                 = @"scaleX";
NSString * const kSLLayerScaleXY                = @"scaleXY";
NSString * const kSLLayerScaleY                 = @"scaleY";
NSString * const kSLLayerSize                   = @"size";
NSString * const kSLLayerSubscaleXY             = @"subscaleXY";
NSString * const kSLLayerSubtranslationX        = @"subtranslationX";
NSString * const kSLLayerSubtranslationXY       = @"subtranslationXY";
NSString * const kSLLayerSubtranslationY        = @"subtranslationY";
NSString * const kSLLayerSubtranslationZ        = @"subtranslationZ";
NSString * const kSLLayerTranslationX           = @"translationX";
NSString * const kSLLayerTranslationXY          = @"translationXY";
NSString * const kSLLayerTranslationY           = @"translationY";
NSString * const kSLLayerTranslationZ           = @"translationZ";
NSString * const kSLLayerZPosition              = @"zPosition";
NSString * const kSLLayerShadowColor            = @"shadowColor";
NSString * const kSLLayerShadowOffset           = @"shadowOffset";
NSString * const kSLLayerShadowOpacity          = @"shadowOpacity";
NSString * const kSLLayerShadowRadius           = @"shadowRadius";

@implementation CALayer (SLPopAddition)

// MARK: BASIC

- (void)sl_basicWithName:(NSString *)name to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(SLPopComplete)complete{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:name];
    basicAnimation.toValue   = toValue;
    basicAnimation.duration = duration;
    basicAnimation.completionBlock = complete;
    [self pop_addAnimation:basicAnimation forKey:key];
}

- (void)sl_basicWithName:(NSString *)name from:(id)fromValue to:(id)toValue duration:(CGFloat)duration key:(NSString *)key complete:(SLPopComplete)complete{
    POPBasicAnimation *basicAnimation = [POPBasicAnimation animationWithPropertyNamed:name];
    basicAnimation.toValue   = toValue;
    basicAnimation.fromValue = fromValue;
    basicAnimation.duration = duration;
    basicAnimation.completionBlock = complete;
    [self pop_addAnimation:basicAnimation forKey:key];
}

// MARK: SPRING

- (void)sl_springWithName:(NSString *)propertyNamed to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(SLPopComplete)complete{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:propertyNamed];
    springAnimation.toValue    = toValue;
    springAnimation.springBounciness = bounce;
    springAnimation.springSpeed = speed;
    springAnimation.completionBlock = complete;
    [self pop_addAnimation:springAnimation forKey:key];
}

- (void)sl_springWithName:(NSString *)propertyNamed from:(id)fromValue to:(id)toValue bounce:(CGFloat)bounce speed:(CGFloat)speed key:(NSString *)key complete:(SLPopComplete)complete{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:propertyNamed];
    springAnimation.fromValue  = fromValue;
    springAnimation.toValue    = toValue;
    springAnimation.springBounciness = bounce;
    springAnimation.springSpeed = speed;
    springAnimation.completionBlock = complete;
    [self pop_addAnimation:springAnimation forKey:key];
}

- (void)sl_removeAllAnimations{
    [self pop_removeAllAnimations];
}

/*
 *  摇动
 */
-(void)shake{
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 5;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfa.duration = 0.3f;
    //重复
    kfa.repeatCount = 2;
    //移除
    kfa.removedOnCompletion = YES;
    [self addAnimation:kfa forKey:@"shake"];
}

/*
 *  摇动
 */
-(void)shakeLayer{
    CAKeyframeAnimation *kfaX = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 5;
    kfaX.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfaX.duration = 0.3f;
    //重复
    kfaX.repeatCount = 0;
    //移除
    kfaX.removedOnCompletion = YES;
    
    CAKeyframeAnimation *kfaY = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    CGFloat sY = 5;
    kfaY.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    //时长
    kfaY.duration = 0.3f;
    //重复
    kfaY.repeatCount = 0;
    //移除
    kfaY.removedOnCompletion = YES;
    
    [self addAnimation:kfaY forKey:@"shake"];
}

@end
