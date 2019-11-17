//
//  BSTopicPictureShowVIewController.m
//  BSApp
//
//  Created by Johnson on 2019/11/3.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTopicPictureShowVIewController.h"
#import "UIImageView+WebCache.h"
#import "BSHomeTopicsModel.h"

@interface BSTopicPictureShowVIewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *contentImageView;

@end

@implementation BSTopicPictureShowVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupSubviews];
}

- (UIImageView *)contentImageView
{
    if (!_contentImageView)
    {
        _contentImageView = [[UIImageView alloc]init];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _contentImageView;
}

- (void)setupSubviews
{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.scrollView];
}

- (void)setModel:(BSHomeTopicsModel *)model
{
    _model = model;
    [self.scrollView addSubview:self.contentImageView];
    [self.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.image2] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        //
    } completed:nil];
}


@end
