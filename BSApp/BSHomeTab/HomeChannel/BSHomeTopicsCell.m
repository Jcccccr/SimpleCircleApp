//
//  BSHomeTopicsCell.m
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeTopicsCell.h"
#import "BSHomeTopicsModel.h"
#import "BSTopicsTopBar.h"
#import "BSTopicsBottomBar.h"
#import "UIView+Frame.h"
#import "UILabel+EstimateSize.h"
#import "BSContant.h"
#import "UIImageView+WebCache.h"
#import "BSTopicPictureView.h"
#import "BSTopicVideoView.h"
#import "BSTopicAudioView.h"

@interface BSHomeTopicsCell()

@property (nonatomic, strong) BSTopicsTopBar *topBar;

@property (nonatomic, strong) UILabel *mainTextLabel;

@property (nonatomic, strong) BSTopicsBottomBar *bottomBar;

@property (nonatomic, strong) BSTopicPictureView *pictureView;

@property (nonatomic, strong) BSTopicVideoView *videoView;

@property (nonatomic, strong) BSTopicAudioView *audioView;

@property (nonatomic, strong) UIButton *moreBtn;

@end


@implementation BSHomeTopicsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (BSTopicsTopBar *)topBar
{
    if (!_topBar)
    {
        _topBar = [[BSTopicsTopBar alloc]init];
//        _topBar.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:_topBar];
    }
    return _topBar;
}


- (UILabel *)mainTextLabel
{
    if (!_mainTextLabel)
    {
        _mainTextLabel = [[UILabel alloc]init];
        _mainTextLabel.numberOfLines = 0;
        _mainTextLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_mainTextLabel];
    }
    return _mainTextLabel;
}


- (BSTopicsBottomBar *)bottomBar
{
    if (!_bottomBar)
    {
        _bottomBar = [[BSTopicsBottomBar alloc]init];
//        _bottomBar.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_bottomBar];
    }
    return _bottomBar;
}


- (BSTopicPictureView *)pictureView
{
    if (!_pictureView)
    {
        _pictureView = [[BSTopicPictureView alloc]init];
        [self addSubview:_pictureView];
        typeof(self) wkSelf = self;
        _pictureView.clickBlock = ^(NSString * _Nonnull imageUrlStr) {
            if (imageUrlStr && wkSelf.eventBlock)
            {
                wkSelf.eventBlock(cellEventTypeGetAllImage);
            }
        };
    }
    return _pictureView;
}


- (BSTopicVideoView *)videoView
{
    if (!_videoView)
    {
        _videoView = [[BSTopicVideoView alloc]init];
        [self addSubview:_videoView];
        typeof(self) wkSelf = self;
        _videoView.playVideoBlock = ^(NSString * _Nonnull videoUrl) {
            if (videoUrl && wkSelf.eventBlock)
            {
                wkSelf.eventBlock(cellEventTypePlayVideo);
            }
        };
    }
    return _videoView;
}


- (BSTopicAudioView *)audioView
{
    if (!_audioView)
    {
        _audioView = [[BSTopicAudioView alloc]init];
        [self addSubview:_audioView];
        typeof(self) wkSelf = self;
        _audioView.playAudioBlock = ^(NSString * _Nonnull videoUrl) {
            if (videoUrl && wkSelf.eventBlock)
            {
                wkSelf.eventBlock(cellEventTypePlayAudio);
            }
        };
    }
    return _audioView;
}

- (UIButton *)moreBtn
{
    if (!_moreBtn)
    {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self addSubview:_moreBtn];
    }
    return _moreBtn;
}



- (void)setModel:(BSHomeTopicsModel *)model
{
    _model = model;
    self.topBar.name = model.name;
    self.topBar.time = model.created_at;
    self.topBar.nameImageUrl = model.profile_image;
    self.mainTextLabel.text = model.text;
    self.bottomBar.giveLike = [model.love integerValue];
    self.bottomBar.dissLike = [model.hate integerValue];
    self.bottomBar.forwarding = [model.repost integerValue];
    self.bottomBar.comments = [model.comment integerValue];
    
    if (model.videouri.length) {
        // 视频
        self.videoView.model = model;
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.audioView.hidden = YES;
    } else if (model.voiceuri.length) {
        // 音频
        self.audioView.model = model;
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.audioView.hidden = NO;
    } else {
        // 图片
        self.pictureView.model = model;
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.audioView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.topBar.frame = CGRectMake(0, 0, self.width, 70);
    CGSize size = [UILabel estimateSizeOfText:self.mainTextLabel.text
                                      withMaxWidth:self.width - cellMarginHorizontal*2 font:[UIFont systemFontOfSize:15] LineSpace:0];
    self.mainTextLabel.frame = CGRectMake(cellMarginHorizontal, 70, size.width, size.height);
    self.bottomBar.frame = CGRectMake(0, _model.cellHeight - 50, self.width, 50);
    
    self.pictureView.frame = _model.cellImageFrame;
    self.videoView.frame = _model.cellImageFrame;
    self.audioView.frame = _model.cellImageFrame;
}


- (void)setFrame:(CGRect)frame
{
    frame =  CGRectMake(
                        frame.origin.x + cellMarginHorizontal,
                        frame.origin.y + cellMargin,
                        frame.size.width - cellMarginHorizontal * 2,
                        _model.cellHeight - cellMargin
                        );
    [super setFrame:frame];
}


#pragma mark - Class Method
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"cell";
    BSHomeTopicsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell)
    {
        cell = [[BSHomeTopicsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

@end
