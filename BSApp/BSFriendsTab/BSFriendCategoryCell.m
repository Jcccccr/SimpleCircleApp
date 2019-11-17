//
//  BSFriendCategoryCell.m
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSFriendCategoryCell.h"
#import "BSHeader.h"
#import "Masonry.h"

@interface BSFriendCategoryCell()

@property (nonatomic, strong) UIView *leftTipView;

@end

@implementation BSFriendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)init
{
    self = [super init];
    [self addSubview:self.leftTipView];
    [self.leftTipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(4);
    }];
    self.leftTipView.hidden = YES;
    return self;
}


- (void)setCellModel:(BSFriendCategoryCellModel *)cellModel
{
    self.textLabel.text = cellModel.name;
    self.textLabel.textColor = [UIColor darkGrayColor];
    [self.textLabel setFont:[UIFont systemFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.leftTipView.hidden = selected? NO : YES;
    self.textLabel.textColor = selected?BSRGBAColor(192, 62, 66,1.0):[UIColor darkGrayColor];
}

- (UIView *)leftTipView
{
    if (!_leftTipView)
    {
        _leftTipView = [[UIView alloc]init];
        _leftTipView.backgroundColor = BSRGBAColor(192, 62, 66,1.0);
    }
    return _leftTipView;
}

@end
