//
//  BSPushMenuView.m
//  BSApp
//
//  Created by Johnson on 2019/11/3.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSPushMenuView.h"
#import "BSMenuBtn.h"
#import "UIView+Frame.h"
#import <pop/POP.h>
#import "BSHeader.h"

@interface BSPushMenuView()

@property (nonatomic, strong) NSMutableArray<BSMenuBtn *> *buttons;

@property (nonatomic, strong) UIImageView *titleImageView;

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation BSPushMenuView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupMenuBtns];
    }
    return self;
}


- (NSMutableArray<BSMenuBtn *> *)buttons
{
    if (!_buttons)
    {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIImageView *)titleImageView
{
    if (!_titleImageView)
    {
        _titleImageView = [[UIImageView alloc]init];
        [self addSubview:_titleImageView];
    }
    return _titleImageView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];;
        [_cancelBtn setBackgroundColor:[UIColor lightGrayColor]];
        [_cancelBtn.layer setCornerRadius:5];
        [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}

- (void)setupMenuBtns
{
    
    self.titleImageView.image = [UIImage imageNamed:@"app_slogan"];
    self.titleImageView.frame = CGRectMake(100, 160, self.width - 200, 20);
    
    NSArray *btnImgsName = @[@"publish-video",
                             @"publish-picture",
                             @"publish-text",
                             @"publish-audio",
                             @"publish-review",
                             @"publish-offline"];
    
    NSArray *btnNames = @[@"发视频",
                          @"发图片",
                          @"发段子",
                          @"发声音",
                          @"审核",
                          @"离线下载"];
    
    for (NSInteger i = 0; i < 6; i++)
    {
        BSMenuBtn *btn = [BSMenuBtn buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setImage:[UIImage imageNamed:btnImgsName[i]] forState:UIControlStateNormal];
        [btn setTitle:btnNames[i] forState:UIControlStateNormal];
        CGRect btnFrame = CGRectZero;
        if (i < 3)
        {
            btnFrame = CGRectMake(i * 100 + 50, 300, 60, 100);
        }else{
            btnFrame = CGRectMake((i - 3) * 100 + 50, 420, 60, 100);
        }
        [self addSubview:btn];
        
        [self.buttons addObject:btn];
        
        CGRect popOraginFrame = CGRectMake(
                                           btnFrame.origin.x,
                                           0,
                                           btnFrame.size.width,
                                           btnFrame.size.height
                                           );
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 0.04 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            animation.fromValue = [NSValue valueWithCGRect:popOraginFrame];
            animation.toValue = [NSValue valueWithCGRect:btnFrame];
            animation.springSpeed = 10;
            animation.springBounciness = 10;
            [btn pop_addAnimation:animation forKey:@"frame"];
        });
    }
    
    CGRect cancelFromFrame = CGRectMake(40, self.height, self.width - 80, 40);
    CGRect cancelToFrame = CGRectMake(40, self.height - 100, self.width - 80, 40);
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    animation.fromValue = [NSValue valueWithCGRect:cancelFromFrame];
    animation.toValue = [NSValue valueWithCGRect:cancelToFrame];
    animation.springSpeed = 10;
    animation.springBounciness = 10;
    [self.cancelBtn pop_addAnimation:animation forKey:@"frame"];
}

- (void)cancel
{
    for (NSInteger i = 0; i < self.buttons.count; i++)
    {
        UIButton *btn = self.buttons[i];
        CGRect toFrame = CGRectMake(btn.x, -50, btn.width, btn.height);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
            animation.fromValue = [NSValue valueWithCGRect:btn.frame];
            animation.toValue = [NSValue valueWithCGRect:toFrame];
            animation.springSpeed = 10;
            animation.springBounciness = 10;
            [btn pop_addAnimation:animation forKey:@"frame"];
            
            if (i == self.buttons.count - 1)
            {
                if (self.cancelblock)
               {
                   self.cancelblock();
               }
            }
            
        });
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self cancel];
}

@end
