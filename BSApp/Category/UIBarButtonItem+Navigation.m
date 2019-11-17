//
//  UIBarButtonItem+Navigation.m
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "UIBarButtonItem+Navigation.h"

@implementation UIBarButtonItem (Navigation)


+ (instancetype)itemWithImage:(UIImage *)image selectedImage:(UIImage *)highlightImage target:(id)target action:(SEL)selector
{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    button.bounds = (CGRect){CGPointZero, [button backgroundImageForState:UIControlStateNormal].size};
    return [[self alloc]initWithCustomView:button];
}

@end
