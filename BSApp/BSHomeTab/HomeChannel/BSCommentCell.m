//
//  BSCommentCell.m
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSCommentCell.h"
#import "UIImageView+WebCache.h"
#import "BSComment.h"
#import "UIView+Frame.h"
#import "UILabel+EstimateSize.h"
#import "BSContant.h"
#import "SDWebImageManager.h"
#import "UIImage+circularImage.h"


@interface BSCommentCell()

@property (nonatomic, strong) UIImageView *headImage;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation BSCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)headImage
{
    if (!_headImage)
    {
        _headImage = [[UIImageView alloc]init];
        [self addSubview:_headImage];
    }
    return _headImage;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel)
    {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.numberOfLines = 0;
        [self addSubview:_contentLabel];
    }
    return _contentLabel;
}


- (void)setCommentModel:(BSComment *)commentModel
{
    _commentModel = commentModel;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager loadImageWithURL:[NSURL URLWithString:commentModel.user.profile_image]
                      options:kNilOptions
                     progress:nil
                    completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        self.headImage.image = [image circularImage];
    }];
    self.nameLabel.text = commentModel.user.username;
    self.timeLabel.text = commentModel.formatCommentTime;
    self.contentLabel.text = commentModel.content;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.headImage.frame = CGRectMake(10, 10, 36, 36);
    self.nameLabel.frame = CGRectMake(60, 10, 300, 20);
    self.timeLabel.frame = CGRectMake(self.width - 60, 6, 100, 30);
    CGSize contentSize = [UILabel estimateSizeOfText:_contentLabel.text withMaxWidth:self.width - cellMargin * 2 - 60 font:[UIFont systemFontOfSize:12] LineSpace:0];
    self.contentLabel.frame = CGRectMake(60, 35, contentSize.width, contentSize.height);
}

- (void)setFrame:(CGRect)frame
{
    frame =  CGRectMake(
                        frame.origin.x + commentCellMargin,
                        frame.origin.y + commentCellMargin,
                        frame.size.width - commentCellMargin * 2,
                        _commentModel.commentCellHeight - commentCellMargin
                        );
    [super setFrame:frame];
}

#pragma mark - class Method
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellID = @"commentCell";
    BSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
       cell = [[BSCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

@end
