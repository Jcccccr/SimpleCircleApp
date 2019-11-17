//
//  BSTopicPictureView.m
//  BSApp
//
//  Created by Johnson on 2019/11/2.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopicPictureView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "BSHomeTopicsModel.h"
#import "BSContant.h"
#import "M13ProgressViewRing.h"
#import "BSHeader.h"


@interface BSTopicPictureView()

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) UIImageView *gifAngleIcon;

@property (nonatomic, strong) UIButton *clickBannerBtn;

@property (nonatomic, strong) M13ProgressViewRing *progressView;

@end

@implementation BSTopicPictureView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.autoresizingMask = UIViewAutoresizingNone;
        self.clipsToBounds = YES;
        [self setupSubviews];
    }
    return self;
}

- (UIButton *)clickBannerBtn
{
    if (!_clickBannerBtn)
    {
        _clickBannerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clickBannerBtn setBackgroundImage:[UIImage imageNamed:@"see-big-picture-background"] forState:UIControlStateNormal];
        [_clickBannerBtn setImage:[UIImage imageNamed:@"see-big-picture"] forState:UIControlStateNormal];
        [_clickBannerBtn setTitle:@"点击查看全部内容" forState:UIControlStateNormal];
        [_clickBannerBtn addTarget:self action:@selector(clickToGetAll) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickBannerBtn;
}

- (M13ProgressViewRing *)progressView
{
    if (!_progressView)
    {
        _progressView = [[M13ProgressViewRing alloc]init];
        _progressView.secondaryColor = [UIColor yellowColor];
        _progressView.primaryColor = BSGlobalYellowColor;
    }
    return _progressView;
}


- (void)setModel:(BSHomeTopicsModel *)model
{
    _model = model;
    
    NSString *urlStr = model.image2;
    if ([urlStr containsString:@".gif"])
    {
        self.gifAngleIcon.hidden = NO;
    }else{
        self.gifAngleIcon.hidden = YES;
    }
    
    if ([model.height floatValue] > topicImageMaxHeight)
    {
        self.clickBannerBtn.hidden = NO;
        self.contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.clickBannerBtn.hidden = YES;
        self.contentImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    self.progressView.hidden = NO;
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.image2] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        CGFloat progress = receivedSize / expectedSize;
        if (!isnan(progress))
        {
            [self.progressView setProgress:1.0 * progress animated:YES];
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        self.progressView.hidden = YES;
    }];
}


- (void)setupSubviews
{
    self.contentImageView = [[UIImageView alloc]init];
    self.gifAngleIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common-gif"]];
    
    [self addSubview:self.progressView];
    [self addSubview:self.contentImageView];
    [self addSubview:self.gifAngleIcon];
    [self addSubview:self.clickBannerBtn];
    
    self.clickBannerBtn.hidden = YES;
    self.gifAngleIcon.hidden = YES;
//    self.progressView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentImageView.frame = self.bounds;
    self.gifAngleIcon.frame = CGRectMake(0, 0, 30, 30);
    self.clickBannerBtn.frame = CGRectMake(0, self.height - 40, self.width, 40);
    self.progressView.frame = CGRectMake((self.width - 50) / 2.0, (self.height - 50) / 2.0, 50, 50);
}

- (void)clickToGetAll
{
    if (self.clickBlock)
    {
        self.clickBlock(_model.image2);
    }
}

@end
