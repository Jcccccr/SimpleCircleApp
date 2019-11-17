//
//  BSFriendsFocusCell.m
//  BSApp
//
//  Created by Johnson on 2019/10/13.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSFriendsFocusCell.h"
#import "BSFriendsFocusCellModel.h"
#import "BSHeader.h"
#import "UIView+Frame.h"
#import "UILabel+EstimateSize.h"
#import "UIImageView+WebCache.h"

static const CGFloat cellMargin = 4;

@interface BSFriendsFocusCell()

@property (nonatomic, strong)UIImageView *focusImage;

@property (nonatomic, strong)UILabel *focusLabel;

@property (nonatomic, strong)UILabel *subLabel;

@property (nonatomic, strong)UIButton *btn;

@property (nonatomic, strong)UIView *cellSeparatorLine;

@end

@implementation BSFriendsFocusCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setModel:(BSFriendsFocusCellModel *)model
{
    [self.focusImage sd_setImageWithURL:[NSURL URLWithString:model.header]];
    self.focusLabel.text = model.screen_name;
    self.subLabel.text = [NSString stringWithFormat:@"关注在追：%@人",model.fans_count];
}

- (void)setupSubViews
{
    [self addSubview:self.focusImage];
    [self addSubview:self.focusLabel];
    [self addSubview:self.subLabel];
    [self addSubview:self.btn];
    [self addSubview:self.cellSeparatorLine];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize titleSize = [UILabel estimateSizeOfText:self.focusLabel.text
                                      withMaxWidth:200
                                              font:[UIFont systemFontOfSize:10]
                                         LineSpace:0];
    CGSize subTitleSize = [UILabel estimateSizeOfText:self.subLabel.text
                                         withMaxWidth:200
                                                 font:[UIFont systemFontOfSize:8]
                                            LineSpace:0];
    self.focusImage.frame = CGRectMake(10, 10, 40, 40);
    self.focusLabel.frame = CGRectMake(70, 15, titleSize.width, titleSize.height);
    self.subLabel.frame = CGRectMake(70, 40, subTitleSize.width, subTitleSize.height);
    self.cellSeparatorLine.frame = CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1);
}


- (UIImageView *)focusImage
{
    if(!_focusImage)
    {
        _focusImage = [[UIImageView alloc]init];
    }
    return _focusImage;
}

- (UILabel *)focusLabel
{
    if (!_focusLabel)
    {
        _focusLabel = [[UILabel alloc]init];
        _focusLabel.textColor = [UIColor darkGrayColor];
        _focusLabel.font = [UIFont systemFontOfSize:10];
    }
    return _focusLabel;
}

- (UILabel *)subLabel
{
    if (!_subLabel)
    {
        _subLabel = [[UILabel alloc]init];
        _subLabel.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
        _subLabel.font = [UIFont systemFontOfSize:8];
    }
    return _subLabel;
}

- (UIButton *)btn
{
    if (!_btn)
    {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _btn;
}

- (UIView *)cellSeparatorLine
{
    if (!_cellSeparatorLine)
    {
        _cellSeparatorLine = [[UIView alloc]init];
        _cellSeparatorLine.backgroundColor = BSGlobalColor;
    }
    return _cellSeparatorLine;
}

@end
