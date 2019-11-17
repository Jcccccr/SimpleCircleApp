//
//  BSTopStatusBarWIndow.m
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopStatusBarWIndow.h"

@implementation BSTopStatusBarWIndow

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.backgroundColor = [UIColor yellowColor];
    self.windowLevel = UIWindowLevelStatusBar;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:gesture];
    self.userInteractionEnabled = YES;
}

- (void)click
{
    NSLog(@"coverClick");
}

@end
