//
//  BSFriendsTabViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSFriendsTabViewController.h"
#import "BSHeader.h"
#import "UIBarButtonItem+Navigation.h"
#import "Masonry.h"
#import "BSFriendCategoryViewController.h"
#import "BSLoginViewController.h"

@interface BSFriendsTabViewController ()

@end

@implementation BSFriendsTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupMainView];
}

- (void)commonInit
{
    self.view.backgroundColor = BSGlobalColor;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] selectedImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsMenuClick)];
}

- (void)setupMainView
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
    UILabel *textLabel = [[UILabel alloc]init];
    textLabel.text = @"快快登录吧，关注百思最in牛人\n好友动态让你过把瘾儿～\n欧耶～～～！";
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = [UIColor grayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.numberOfLines = 0;
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginBtn setTitle:@"立即登陆/注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"立即登陆/注册" forState:UIControlStateHighlighted];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(loginEvent) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageView];
    [self.view addSubview:textLabel];
    [self.view addSubview:loginBtn];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(200);
        make.size.mas_equalTo(CGSizeMake(48, 48));
    }];
    
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(imageView).offset(85);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(textLabel).offset(100);
        make.size.mas_equalTo([loginBtn backgroundImageForState:UIControlStateNormal].size);
    }];
    
}


- (void)loginEvent
{
    [self.navigationController presentViewController:[BSLoginViewController new] animated:YES completion:nil];
}

- (void)friendsMenuClick
{
    [self.navigationController pushViewController:[BSFriendCategoryViewController new] animated:YES];
}

@end
