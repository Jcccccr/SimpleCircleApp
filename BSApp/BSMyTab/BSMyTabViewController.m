//
//  BSMyTabViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSMyTabViewController.h"
#import "BSHeader.h"
#import "UIBarButtonItem+Navigation.h"
#import "UIImage+circularImage.h"
#import "BSMyTabTopCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "BSMySquareModel.h"
#import "BSMySquareButton.h"
#import "MJExtension.h"
#import "BSContant.h"
#import "UIButton+WebCache.h"
#import "BSComicWebViewController.h"
#import "BSSettingViewController.h"


@interface BSMyTabViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, strong) UIView *tableFooterView;

@property (nonatomic, strong) NSMutableArray <BSMySquareModel *> *squareModels;

@end

@implementation BSMyTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BSGlobalColor;
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-setting-icon"] selectedImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(settingClick)];
    UIBarButtonItem *moonModeItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"mine-moon-icon"] selectedImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(moonModeClick)];
    self.navigationItem.rightBarButtonItems = @[settingItem, moonModeItem];
    
    [self setupTableView];
    
    [self loadTableFooterView];
}


- (void)settingClick
{
    UIViewController *setVC = [[BSSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)moonModeClick
{
    
}


- (void)setupTableView
{
    self.contentTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.contentTableView.delegate = self;
    self.contentTableView.dataSource = self;
    self.contentTableView.sectionFooterHeight = 10;
    self.contentTableView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.view addSubview:self.contentTableView];
}


- (void)loadTableFooterView
{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *requestURLStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    [manager GET:requestURLStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *dic = (NSMutableDictionary *)responseObject;
        NSArray *keyValueArray = (NSArray *)dic[@"square_list"];
        self.squareModels =  [BSMySquareModel mj_objectArrayWithKeyValuesArray:keyValueArray];
        [self freshTableFooterViewWithSquareModels];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}


- (void)freshTableFooterViewWithSquareModels
{
    if (!self.squareModels.count) return;
    NSInteger remainderNum = self.squareModels.count % 4;
    NSInteger divisorNum = self.squareModels.count / 4;
    NSInteger rowNum = 0;
    if (remainderNum > 0)
    {
        rowNum = divisorNum + 1;
    }else{
        rowNum = divisorNum;
    }
    
    self.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, mySquareBtnHeight * rowNum)];
    self.tableFooterView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.contentTableView.tableFooterView = self.tableFooterView;
    
    CGFloat squareWidth = SCREEN_WIDTH / 4.0;
    for (NSInteger index = 0; index < self.squareModels.count; index++)
    {
        NSInteger line   = index / 4;
        NSInteger column = index % 4;
        CGPoint squareOrigin = CGPointMake(column * squareWidth, line * mySquareBtnHeight);
        CGRect squareFrame = CGRectMake(squareOrigin.x, squareOrigin.y, squareWidth, mySquareBtnHeight);
        
        BSMySquareModel *model = self.squareModels[index];
        if (model && [model isKindOfClass:[BSMySquareModel class]])
        {
            BSMySquareButton *btn = [BSMySquareButton buttonWithType:UIButtonTypeCustom];
            btn.btnModel = model;
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn sd_setImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal];
            [btn setTitle:model.name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn setFrame:squareFrame];
            [self.tableFooterView addSubview:btn];
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSMyTabTopCell *cell = [BSMyTabTopCell cellWithTableView:tableView];
    if (indexPath.section == 0)
    {
        cell.imageView.image = [[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] circularImage];
        cell.contentText = @"注册/登录";
    }
    if (indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"publish-offline"];
        cell.contentText = @"离线下载";
    }
    return cell;
}



/*
 *  事件集中处理
 */
- (void)routerEventWithName:(NSString *)eventName sender:(id)sender userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:@"squareBtnClickEvent"])
    {
        if (userInfo && [userInfo isKindOfClass:[NSDictionary class]])
        {
            NSString *webUrlStr = userInfo[@"jumpWebUrl"];
            if (webUrlStr.length && [webUrlStr hasPrefix:@"http"]) // 跳转web
            {
                BSComicWebViewController *webVC = [[BSComicWebViewController alloc]init];
                webVC.webUrlString = webUrlStr;
                [self.navigationController pushViewController:webVC animated:YES];
            }
        }
    }
}

@end
