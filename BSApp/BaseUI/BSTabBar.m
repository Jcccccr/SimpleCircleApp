//
//  BSTabBar.m
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTabBar.h"
#import "UIView+Frame.h"
#import "Masonry.h"

@implementation BSTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIButton *publishButton = [[UIButton alloc] init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_y"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_y"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        [publishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo([publishButton backgroundImageForState:UIControlStateNormal].size);
        }];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width / 5;
    int index = 0;
    for (UIControl *control in self.subviews) {
        if (![control isKindOfClass:[UIControl class]] || [control isKindOfClass:[UIButton class]]) continue;
        control.width = width;
        control.x = index > 1 ? width * (index + 1) : width * index;
        index++;
    }
}


- (void)publishClick
{
    if (self.publishBlock)
    {
        self.publishBlock();
    }
}

@end
