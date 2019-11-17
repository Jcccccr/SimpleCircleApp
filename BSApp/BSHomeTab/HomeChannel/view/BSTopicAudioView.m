//
//  BSTopicAudioView.m
//  BSApp
//
//  Created by Johnson on 2019/11/9.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopicAudioView.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
#import "BSHomeTopicsModel.h"
#import "BSContant.h"
#import "M13ProgressViewRing.h"
#import "BSHeader.h"

@interface BSTopicAudioView()

@property (nonatomic, strong) UIImageView *contentImageView;

@property (nonatomic, strong) UIButton *playIcon;

@property (nonatomic, strong) M13ProgressViewRing *progressView;

@end

@implementation BSTopicAudioView


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


- (UIButton *)playIcon
{
    if (!_playIcon)
    {
        _playIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playIcon setBackgroundImage:[UIImage imageNamed:@"playButtonPlay"] forState:UIControlStateNormal];
        [_playIcon addTarget:self action:@selector(clickToPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playIcon;
}

- (M13ProgressViewRing *)progressView
{
    if (!_progressView)
    {
        _progressView = [[M13ProgressViewRing alloc]init];
        _progressView.secondaryColor = [UIColor yellowColor];
        _progressView.primaryColor = BSRGBAColor(0.5, 0.5, 0.5, 1.0);
    }
    return _progressView;
}


- (void)setModel:(BSHomeTopicsModel *)model
{
    _model = model;
    
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
    
//    NSString *urlStr = model.voiceuri;
    
//    if ([urlStr containsString:@".mp4"])
//    {
//        self.playIcon.hidden = NO;
//    }else{
//        self.playIcon.hidden = YES;
//    }
}


- (void)setupSubviews
{
    self.contentImageView = [[UIImageView alloc]init];
    [self addSubview:self.progressView];
    [self addSubview:self.contentImageView];
    [self addSubview:self.playIcon];
    self.playIcon.hidden = NO;
    self.progressView.hidden = YES;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentImageView.frame = self.bounds;
    self.progressView.frame = CGRectMake((self.width - 50) / 2.0, (self.height - 50) / 2.0, 50, 50);
    self.playIcon.frame = CGRectMake(
                                     (self.width - 50) / 2.0,
                                     (self.height - 50) / 2.0,
                                     50,
                                     50);
}

- (void)clickToPlay
{
    if (self.playAudioBlock)
    {
        self.playAudioBlock(_model.voiceuri);
    }
}

@end

