//
//  BSTopicsBottomBar.m
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopicsBottomBar.h"
#import "BSHeader.h"
#import "BSContant.h"
#import "UIView+Frame.h"

#define lineHeight 1

@interface BSTopicsBottomBar()

@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UIButton *dissLikeBtn;
@property (nonatomic, strong) UIButton *forwardBtn;
@property (nonatomic, strong) UIButton *commentBtn;

@end

@implementation BSTopicsBottomBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, lineHeight)];
        lineView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:lineView];
        [self creareBtns];
    }
    return self;
}

- (void)creareBtns
{
    self.likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.likeBtn setImage:[UIImage imageNamed:@"mainCellDing"] forState:UIControlStateNormal];
    [self.likeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.likeBtn addTarget:self action:@selector(clickLikeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.likeBtn];
    
    self.dissLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dissLikeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.dissLikeBtn setImage:[UIImage imageNamed:@"mainCellCai"] forState:UIControlStateNormal];
    [self.dissLikeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.dissLikeBtn addTarget:self action:@selector(clickDisLikeBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.dissLikeBtn];
    
    self.forwardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forwardBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.forwardBtn setImage:[UIImage imageNamed:@"mainCellShare"] forState:UIControlStateNormal];
    [self.forwardBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.forwardBtn addTarget:self action:@selector(clickForWardBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.forwardBtn];
    
    self.commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.commentBtn setImage:[UIImage imageNamed:@"mainCellComment"] forState:UIControlStateNormal];
    [self.commentBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.commentBtn addTarget:self action:@selector(clickCommonBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.commentBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    CGFloat width = (SCREEN_WIDTH - cellMargin*4)/4.0;
    self.likeBtn.frame = CGRectMake(0, lineHeight, width, self.height);
    self.dissLikeBtn.frame = CGRectMake(width, lineHeight, width, self.height);
    self.forwardBtn.frame = CGRectMake(width*2, lineHeight, width, self.height);
    self.commentBtn.frame = CGRectMake(width*3, lineHeight, width, self.height);
}

- (void)setGiveLike:(NSInteger)giveLike
{
    [self.likeBtn setTitle:[NSString stringWithFormat:@"% zd", giveLike] forState:UIControlStateNormal];
}

- (void)setDissLike:(NSInteger)dissLike
{
    [self.dissLikeBtn setTitle:[NSString stringWithFormat:@"% zd", dissLike] forState:UIControlStateNormal];
}

- (void)setForwarding:(NSInteger)forwarding
{
    [self.forwardBtn setTitle:[NSString stringWithFormat:@"% zd", forwarding] forState:UIControlStateNormal];
}

- (void)setComments:(NSInteger)comments
{
    [self.commentBtn setTitle:[NSString stringWithFormat:@"% zd", comments] forState:UIControlStateNormal];
}


- (void)clickLikeBtn
{
    if (self.clickBlock)
    {
        self.clickBlock(self.likeBtn, BottomBarBtnTagGiveLike);
    }
}

- (void)clickDisLikeBtn
{
    if (self.clickBlock)
    {
        self.clickBlock(self.dissLikeBtn, BottomBarBtnTagDissLike);
    }
}

- (void)clickForWardBtn
{
    if (self.clickBlock)
    {
        self.clickBlock(self.forwardBtn, BottomBarBtnTagForwarding);
    }
}

- (void)clickCommonBtn
{
    if (self.clickBlock)
    {
        self.clickBlock(self.commentBtn, BottomBarBtnTagComments);
    }
}

@end
