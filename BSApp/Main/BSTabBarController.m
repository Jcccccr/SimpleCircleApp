//
//  BSTabBarController.m
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSTabBarController.h"
#import "BSHomeTabViewController.h"
#import "BSNewTabViewController.h"
#import "BSFriendsTabViewController.h"
#import "BSMyTabViewController.h"
#import "UIImage+originImage.h"
#import "BSTabBar.h"
#import "BSNavigationController.h"
#import "BSPushMenuView.h"
#import "BSHeader.h"
#import "BSTopStatusBarWIndow.h"
#import "BSContant.h"


@interface BSTabBarController ()<UITabBarDelegate, BSTabbarEventProtocal>

@property (nonatomic, strong) UIWindow *mainMenuWindow;

@property (nonatomic, strong) UIWindow *statusBarCoverWindow;

@property (nonatomic, weak) UITabBarItem *curSelectedBarItem;

@end

@implementation BSTabBarController

+ (void)initialize
{
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *attri = [NSMutableDictionary dictionary];
    attri[NSFontAttributeName] = [UIFont fontWithName:@"blod" size:30];
    attri[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:attri forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildVC];
    [self setupTabbar];
    self.curSelectedBarItem = self.tabBar.items.firstObject;
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)setupChildVC
{
    [self setupChildNavgVCWithContentVC:[BSHomeTabViewController new] title:@"精华" tabImage:[UIImage imageWithOriRenderingImage:@"tabBar_essence_icon"] selectedTabImage:[UIImage imageWithOriRenderingImage:@"tabBar_essence_click_icon"]];
    [self setupChildNavgVCWithContentVC:[BSNewTabViewController new] title:@"新帖" tabImage:[UIImage imageWithOriRenderingImage:@"tabBar_new_icon"] selectedTabImage:[UIImage imageWithOriRenderingImage:@"tabBar_new_click_icon"]];
    [self setupChildNavgVCWithContentVC:[BSFriendsTabViewController new] title:@"关注" tabImage:[UIImage imageWithOriRenderingImage:@"tabBar_friendTrends_icon"] selectedTabImage:[UIImage imageWithOriRenderingImage:@"tabBar_friendTrends_click_icon"]];
    [self setupChildNavgVCWithContentVC:[BSMyTabViewController new] title:@"我" tabImage:[UIImage imageWithOriRenderingImage:@"tabBar_me_icon"] selectedTabImage:[UIImage imageWithOriRenderingImage:@"tabBar_me_click_icon"]];
}


- (void)setupTabbar
{
    BSTabBar *tabbar = [[BSTabBar alloc]init];
    tabbar.publishBlock = ^{
        [self setupPublishMenu];
    };
    [self setValue:tabbar forKeyPath:@"tabBar"];
}


- (void)setupChildNavgVCWithContentVC:(UIViewController *)vc title:(NSString *)title tabImage:(UIImage *)image selectedTabImage:(UIImage *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:[[BSNavigationController alloc]initWithRootViewController:vc]];
}

- (void)setupPublishMenu
{
    UIWindow *window = [[UIWindow alloc]init];
    window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.85];
    window.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    window.hidden = NO;
    self.mainMenuWindow = window;

    BSPushMenuView *menu = [[BSPushMenuView alloc]initWithFrame:window.bounds];
    [window addSubview:menu];
    typeof(self) wkSelf = self;
    [menu setCancelblock:^{
        wkSelf.mainMenuWindow = nil;
    }];

}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item isEqual:self.curSelectedBarItem])
    {
        [[NSNotificationCenter defaultCenter]postNotificationName:BSTabBarItemDidSingleClickNotifiaction object:nil];
    }else{
        self.curSelectedBarItem = item;
        [[NSNotificationCenter defaultCenter]postNotificationName:BSTabBarItemDidSelectNotifiaction object:nil];
    }
}

@end
