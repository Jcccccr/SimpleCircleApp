//
//  UIView+Frame.h
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property (assign, nonatomic) CGFloat x;

@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat centerX;

@property (assign, nonatomic) CGFloat centerY;

@property (assign, nonatomic) CGFloat width;

@property (assign, nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
