//
//  BSChannelSegmentView.m
//  BSApp
//
//  Created by Johnson on 2019/10/20.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSChannelSegmentView.h"
#import "BSHeader.h"

@interface BSChannelSegmentView()

@property (nonatomic, strong) NSMutableArray <UIButton *> *titleBtnArray;

@property (nonatomic, strong) UIView *segmentScrollLine;

@end

@implementation BSChannelSegmentView


- (NSMutableArray *)titleBtnArray
{
    if (!_titleBtnArray)
    {
        _titleBtnArray = [NSMutableArray array];
    }
    return _titleBtnArray;
}


- (UIView *)segmentScrollLine
{
    if (!_segmentScrollLine)
    {
        _segmentScrollLine = [[UIView alloc]init];
    }
    return _segmentScrollLine;
}


- (void)setChannelTitles:(NSArray<NSString *> *)channelTitles
{
    _channelTitles = channelTitles;
    [self setupSubViews];
}


- (void)setCurIndex:(NSInteger)curIndex
{
    _curIndex = curIndex;
    for (UIButton *btn in self.titleBtnArray)
    {
        if (btn.tag == curIndex) {
            btn.selected = YES;
            CGFloat lineWidth = (SCREEN_WIDTH / self.titleBtnArray.count);
            CGFloat lineHeight = 1.;
            self.segmentScrollLine.frame = CGRectMake(curIndex * lineWidth, self.bounds.size.height - lineHeight, lineWidth, lineHeight);
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        }else{
            btn.selected = NO;
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }
}


- (void)setFrame:(CGRect)frame
{
    CGRect segmentFrame = CGRectMake(frame.origin.x, frame.origin.y, SCREEN_WIDTH, frame.size.height);
    [super setFrame:segmentFrame];
}


- (void)setupSubViews
{
    for (NSInteger index = 0; index < self.channelTitles.count; index++)
    {
        UIButton *labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        labelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        labelBtn.tag = index;
        labelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [labelBtn setTitle:self.channelTitles[index] forState:UIControlStateNormal];
        [labelBtn setTitleColor:self.seletedColor forState:UIControlStateSelected];
        [labelBtn setTitleColor:self.nomalColor forState:UIControlStateNormal];
        [self.titleBtnArray addObject:labelBtn];
        [self addSubview:labelBtn];
        [labelBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.segmentScrollLine.backgroundColor = self.seletedColor;
    [self addSubview:self.segmentScrollLine];
}


- (void)titleClick:(UIButton *)titleBtn
{
    if (titleBtn && [titleBtn isKindOfClass:[UIButton class]])
    {
        NSInteger index = titleBtn.tag;
        self.curIndex = index;
        if (self.clickBlok)
        {
            self.clickBlok(titleBtn, index);
        }
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    for (NSInteger i = 0; i < self.titleBtnArray.count; i++)
    {
        CGFloat labelWidth = SCREEN_WIDTH / self.titleBtnArray.count;
        CGFloat labelHeight = self.frame.size.height;
        CGFloat originX = labelWidth * i;
        CGFloat origonY = 0;
        UIButton *titleLabel = self.titleBtnArray[i];
        titleLabel.frame = CGRectMake(originX, origonY, labelWidth, labelHeight);
    }
}

@end
