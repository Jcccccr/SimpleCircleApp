//
//  BSTopicsTopBar.m
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopicsTopBar.h"
#import "UIImageView+WebCache.h"
#import "BSHeader.h"
#import "UIView+Frame.h"
#import "UIImage+circularImage.h"

@interface BSTopicsTopBar()

@property (nonatomic, strong) UIImageView *headImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *moreBtn;

@end

@implementation BSTopicsTopBar

- (UIImageView *)headImage
{
    if (!_headImage)
    {
        _headImage = [[UIImageView alloc]init];
    }
    return _headImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:10];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.headImage];
        [self addSubview:self.timeLabel];
        [self addSubview:self.nameLabel];
        [self addSubview:self.moreBtn];
    }
    return self;
}

- (void)setName:(NSString *)name
{
    self.nameLabel.text = name;
}

- (void)setTime:(NSString *)time
{
    self.timeLabel.text = time;
}

- (void)setNameImageUrl:(NSString *)nameImageUrl
{
    _nameImageUrl = nameImageUrl;
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:nameImageUrl]
                      options:kNilOptions
                     progress:nil
                    completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        self.headImage.image = [image circularImage];
    }];
}

- (void)moreBtnClick
{
    if (self.block)
    {
        self.block(self.moreBtn);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImage.frame = CGRectMake(10, 10, 40, 40);
    self.nameLabel.frame = CGRectMake(70, 5, 300, 30);
    self.timeLabel.frame = CGRectMake(70, 30, 300, 30);
    self.moreBtn.frame = CGRectMake(self.width - 50, 10, 50, 50);
}



@end
