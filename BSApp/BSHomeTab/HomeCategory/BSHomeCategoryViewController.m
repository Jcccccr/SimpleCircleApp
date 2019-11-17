//
//  BSHomeCategoryViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/13.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeCategoryViewController.h"
#import "BSHomeCategoryCellModel.h"
#import "BSHomeCategoryCell.h"
#import "BSHeader.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "MJExtension.h"

static NSString * const cellID = @"categoryTableViewCellID";

static const CGFloat cellHeight = 70;

@interface BSHomeCategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *categoryTableView;

@property (nonatomic, strong) NSMutableArray <BSHomeCategoryCellModel *> *models;

@end

@implementation BSHomeCategoryViewController

- (UITableView *)categoryTableView
{
    if (!_categoryTableView)
    {
        _categoryTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _categoryTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BSGlobalColor;
    [self.view addSubview:self.categoryTableView];
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryTableView.backgroundColor = BSGlobalColor;
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self requestData];
}

- (void)requestData
{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php?a=tags_list&c=subscribe";
    [manager GET:urlStr parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        NSMutableDictionary *data = (NSMutableDictionary *)responseObject;
        NSArray *array = data[@"rec_tags"];
        self.models = [BSHomeCategoryCellModel mj_objectArrayWithKeyValuesArray:array];
        [self.categoryTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSHomeCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[BSHomeCategoryCell alloc]init];
        cell.model = self.models[indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
