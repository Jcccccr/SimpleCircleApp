//
//  BSMySquareButton.m
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSMySquareButton.h"
#import "BSHeader.h"
#import "UIView+Frame.h"
#import "BSMySquareModel.h"

@interface BSMySquareButton()

@property (nonatomic, strong) UIView *horizontalLine;

@property (nonatomic, strong) UIView *verticalLine;

@end

@implementation BSMySquareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.horizontalLine = [[UIView alloc]init];
        self.verticalLine = [[UIView alloc]init];
        self.horizontalLine.backgroundColor = self.verticalLine.backgroundColor = BSGlobalColor;
        [self addSubview:self.horizontalLine];
        [self addSubview:self.verticalLine];
        [self addTarget:self action:@selector(handleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(
                                      (self.width - 54)/2.0,
                                      20,
                                      54,
                                      54
                                      );
    
    self.titleLabel.frame = CGRectMake(0, self.height - 30, self.width, 30);
    
    self.horizontalLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
    
    self.verticalLine.frame = CGRectMake(self.width -1, 0, 1, self.height);
}


- (void)handleEvent
{
    [self routerEventWithName:@"squareBtnClickEvent" sender:self userInfo:@{@"jumpWebUrl":self.btnModel.url}];
}

@end
