//
//  BSHomeTabViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeTabViewController.h"
#import "BSHeader.h"
#import "BSContant.h"
#import "UIBarButtonItem+Navigation.h"
#import "BSHomeCategoryViewController.h"
#import "BSChannelSegmentView.h"
#import "BSHomeTopicsViewController.h"

@interface BSHomeTabViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) BSChannelSegmentView *segmentView;

@property (nonatomic, strong) UIScrollView *pageScrollContentView;

@end

@implementation BSHomeTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BSGlobalColor;
    UIImageView *appTitleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"main_title"]];
    appTitleImageView.frame = CGRectMake((SCREEN_WIDTH - topicTopBarHeight * 2.3) / 2.0, -10, topicTopBarHeight * 2.3, topicTopBarHeight);
    [self.navigationController.navigationBar addSubview:appTitleImageView];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] selectedImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(homeCategoryClick)];
    
    [self setupChildVc];
    
    [self setupSegmentView];
    
    [self setupScrollChannelContentView];
    
    [self scrollPageWithIndex:0];
}


- (void)homeCategoryClick
{
    [self.navigationController pushViewController:[[BSHomeCategoryViewController alloc]init] animated:YES];
}


- (void)setupChildVc
{
    [self setupChildTopicVcWithType:TopicTypeAll vcTitle:@"All"];
    [self setupChildTopicVcWithType:TopicTypeVideos vcTitle:@"VLog"];
    [self setupChildTopicVcWithType:TopicTypePictures vcTitle:@"Ins."];
    [self setupChildTopicVcWithType:TopicTypejokes vcTitle:@"Tips"];
    [self setupChildTopicVcWithType:TopicTypeAudios vcTitle:@"Audio"];
}

- (void)setupChildTopicVcWithType:(TopicType)type vcTitle:(NSString *)title
{
    BSHomeTopicsViewController *vc = [BSHomeTopicsViewController new];
    vc.title = title;
    vc.topicType = type;
    [self addChildViewController:vc];
}


- (void)setupSegmentView
{
    self.segmentView = [[BSChannelSegmentView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    self.segmentView.backgroundColor = [UIColor whiteColor];
    self.segmentView.nomalColor = [UIColor darkGrayColor];
    self.segmentView.seletedColor = BSGlobalYellowColor;
    
    NSMutableArray *array = [NSMutableArray array];
    for(UIViewController *vc in self.childViewControllers)
    {
        if (vc.title)
        {
            [array addObject:vc.title];
        }
    }
    self.segmentView.channelTitles = array;
    self.segmentView.curIndex = 0;
    [self.view addSubview:self.segmentView];
    
    typeof(self) weakSelf = self;
    self.segmentView.clickBlok = ^(UIButton * _Nonnull titleLabelBtn, NSInteger index) {
        [weakSelf.pageScrollContentView setContentOffset:CGPointMake(index * SCREEN_WIDTH, 0) animated:YES];
    };
}


- (void)setupScrollChannelContentView
{
    self.pageScrollContentView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.pageScrollContentView.bounces = NO;
    self.pageScrollContentView.showsHorizontalScrollIndicator = NO;
    self.pageScrollContentView.showsVerticalScrollIndicator = NO;
    self.pageScrollContentView.backgroundColor = BSGlobalColor;
    self.pageScrollContentView.contentSize = CGSizeMake(SCREEN_WIDTH * self.childViewControllers.count, 0);
    self.pageScrollContentView.pagingEnabled = YES;
    self.pageScrollContentView.delegate = self;
    [self.view insertSubview:self.pageScrollContentView atIndex:0];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / SCREEN_WIDTH;
    self.segmentView.curIndex = index;
    [self scrollPageWithIndex:index];
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger index = offsetX / SCREEN_WIDTH;
    self.segmentView.curIndex = index;
    [self scrollPageWithIndex:index];
}


- (void)scrollPageWithIndex:(NSInteger) index
{
    UIViewController *childVc = self.childViewControllers[index];
    UIColor *radomColor = BSRGBAColor((arc4random() % 256), (arc4random() % 256), (arc4random() % 256), 1.0);
    childVc.view.backgroundColor = radomColor;
    childVc.view.frame = CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.pageScrollContentView addSubview:childVc.view];
}

@end
