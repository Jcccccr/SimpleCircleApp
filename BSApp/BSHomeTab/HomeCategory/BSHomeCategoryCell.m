//
//  BSHomeCategoryCell.m
//  BSApp
//
//  Created by Johnson on 2019/10/13.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeCategoryCell.h"
#import "BSHomeCategoryCellModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "BSHeader.h"
#import "UILabel+EstimateSize.h"
#import "UIView+Frame.h"

static const CGFloat cellMargin = 5;

@interface BSHomeCategoryCell()

@property (nonatomic, strong)UIImageView *themeImage;

@property (nonatomic, strong)UILabel *themeLabel;

@property (nonatomic, strong)UILabel *subLabel;

@property (nonatomic, strong)UIButton *btn;

@end

@implementation BSHomeCategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    frame =  CGRectMake(
                        frame.origin.x + cellMargin,
                        frame.origin.y + cellMargin,
                        frame.size.width - cellMargin * 2,
                        frame.size.height - cellMargin
                        );
    [super setFrame:frame];
}

- (void)setModel:(BSHomeCategoryCellModel *)model
{
    [self.themeImage sd_setImageWithURL:[NSURL URLWithString:model.image_list]];
    self.themeLabel.text = model.theme_name;
    self.subLabel.text = [NSString stringWithFormat:@"关注数量：%@",model.theme_id];
}

- (void)setupSubViews
{
    [self addSubview:self.themeImage];
    [self addSubview:self.themeLabel];
    [self addSubview:self.subLabel];
    [self addSubview:self.btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize titleSize = [UILabel estimateSizeOfText:self.themeLabel.text
                                      withMaxWidth:200
                                              font:[UIFont systemFontOfSize:15]
                                         LineSpace:0];
    CGSize subTitleSize = [UILabel estimateSizeOfText:self.subLabel.text
                                         withMaxWidth:200
                                                 font:[UIFont systemFontOfSize:10]
                                            LineSpace:0];
    self.themeImage.frame = CGRectMake(10, 10, 50, 50);
    self.themeLabel.frame = CGRectMake(70, 15, titleSize.width, titleSize.height);
    self.subLabel.frame = CGRectMake(70, 40, subTitleSize.width, subTitleSize.height);
}


- (UIImageView *)themeImage
{
    if(!_themeImage)
    {
        _themeImage = [[UIImageView alloc]init];
    }
    return _themeImage;
}

- (UILabel *)themeLabel
{
    if (!_themeLabel)
    {
        _themeLabel = [[UILabel alloc]init];
        _themeLabel.textColor = [UIColor darkGrayColor];
        _themeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _themeLabel;
}

- (UILabel *)subLabel
{
    if (!_subLabel)
    {
        _subLabel = [[UILabel alloc]init];
        _subLabel.textColor = [[UIColor darkGrayColor] colorWithAlphaComponent:0.8];
        _subLabel.font = [UIFont systemFontOfSize:10];
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

@end
