//
//  XYZPopCenterView.m
//  XYZPopView
//
//  Created by xieyingze on 16/8/7.
//  Copyright © 2016年 xieyingze. All rights reserved.
//

#import "XYZPopCenterView.h"

@implementation XYZPopCenterView

- (void)awakeFromNib
{
    
}

+ (id)initFromXIB
{
    NSArray* xibs = [[NSBundle mainBundle]loadNibNamed:@"XYZPopCenterView" owner:self options:nil];
    
    return xibs[0];
}

@end
