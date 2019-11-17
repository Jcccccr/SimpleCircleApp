//
//  BSMyTabTopCell.m
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSMyTabTopCell.h"
#import "UIView+Frame.h"
#import "UILabel+EstimateSize.h"

static NSString * const myCellId = @"myCellId";

@interface BSMyTabTopCell()

@property (nonatomic, strong)UILabel *contentLabel;

@end

@implementation BSMyTabTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.font = [UIFont systemFontOfSize:20];
    self.contentLabel.text = @"";
    [self addSubview:self.contentLabel];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setContentText:(NSString *)contentText
{
    _contentText = contentText;
    _contentLabel.text = contentText;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(20, 10, self.height
                                      - 20, self.height - 20);
    
    CGSize contentLabelSize  = [UILabel estimateSizeOfText:self.contentLabel.text
                                              withMaxWidth:self.width
                                                      font:[UIFont systemFontOfSize:20]
                                                 LineSpace:0];
    CGRect contentLabelFrame = CGRectMake(
                                          self.imageView.x + self.imageView.width + 20,
                                          (self.height - contentLabelSize.height)/2.0,
                                          contentLabelSize.width,
                                          contentLabelSize.height
                                          );
    self.contentLabel.frame = contentLabelFrame;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    BSMyTabTopCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if (!cell)
    {
        cell = [[BSMyTabTopCell alloc]init];
    }
    return cell;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView text:(NSString *)title
{
    BSMyTabTopCell *cell = [BSMyTabTopCell cellWithTableView:tableView];
    if (title.length)
    {
        cell.contentText = title;
    }
    return cell;
}

@end
