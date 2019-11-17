//
//  BSFriendCategoryViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSFriendCategoryViewController.h"
#import "BSHeader.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "BSFriendCategoryCellModel.h"
#import "BSFriendCategoryCell.h"
#import "MJExtension.h"
#import "BSFriendsFocusCell.h"
#import "BSFriendsFocusCellModel.h"
#import "MJRefresh.h"
#import "UIScrollView+MJRefresh.h"

static const NSInteger categoryLeftWidth = 100;

#define curSelectedCategoryModel ((BSFriendCategoryCellModel *)self.categoryModels[self.categoryTableView.indexPathForSelectedRow.row])


@interface BSFriendCategoryViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *categoryTableView;

@property (nonatomic, strong) UITableView *focusTableView;

@property (nonatomic, strong) NSArray<BSFriendCategoryCellModel *> *categoryModels;

@end

@implementation BSFriendCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BSGlobalColor;
    self.navigationItem.title = @"推荐关注";
    [self setupSubViews];
    [self requestCategory];
}


- (void)setupSubViews
{
    self.categoryTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, categoryLeftWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.focusTableView = [[UITableView alloc]initWithFrame:CGRectMake(categoryLeftWidth, 0, self.view.bounds.size.width - categoryLeftWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    [self.view addSubview:self.categoryTableView];
    [self.view addSubview:self.focusTableView];
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.focusTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.focusTableView.rowHeight = 60;
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.focusTableView.delegate = self;
    self.focusTableView.dataSource = self;
    [self setupRefresh];
}

- (void)setupRefresh
{
    self.focusTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.focusTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
}


- (void)headerRefresh
{
    [self requestFocusDataWithCategoryModel:curSelectedCategoryModel];
}

- (void)footerRefresh
{
    [self requestNextPageFocusDataWithCategoryModel:curSelectedCategoryModel];
}

/*
 * 请求左侧数据
 */
- (void)requestCategory
{
    [SVProgressHUD show];
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php?a=category&c=subscribe";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *list = dic[@"list"];
        self.categoryModels = [BSFriendCategoryCellModel mj_objectArrayWithKeyValuesArray:list];
        [self.categoryTableView reloadData];
        [SVProgressHUD dismiss];
        
        //默认选中第一行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        [self.focusTableView.mj_header beginRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
}


/*
 * 请求右侧第一页数据
 */
- (void)requestFocusDataWithCategoryModel:(BSFriendCategoryCellModel *)model
{
    [SVProgressHUD show];
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php?a=list&c=subscribe";
    urlStr = [urlStr stringByAppendingFormat:@"&category_id=%@", model.id];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (curSelectedCategoryModel == model) // 以最终的频道为准,如果此时网络返回数据对应的频道不是当前选中的频道则不刷新页面
        {
            NSMutableDictionary *dic = (NSMutableDictionary *)responseObject;
            model.focusData = [NSMutableDictionary dictionaryWithDictionary:dic];
            model.focusDataPage = 1;
        
            NSMutableArray *list = (NSMutableArray *)model.focusData[@"list"];
            model.totalListCount = list.count;
            
            [self.focusTableView reloadData];
            [SVProgressHUD dismiss];
            [self.focusTableView.mj_header endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [self.focusTableView.mj_header endRefreshing];
    }];
}

/*
* 请求右侧更多页数据
*/
- (void)requestNextPageFocusDataWithCategoryModel:(BSFriendCategoryCellModel *)model
{
    NSInteger requestPage = model.focusDataPage + 1;
    [SVProgressHUD show];
    NSString *urlStr = @"http://api.budejie.com/api/api_open.php?a=list&c=subscribe";
    urlStr = [urlStr stringByAppendingFormat:@"&category_id=%@", model.id];
    urlStr = [urlStr stringByAppendingFormat:@"&page=%zd",requestPage];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil headers:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (curSelectedCategoryModel == model)
        {
            NSMutableDictionary *dic = (NSMutableDictionary *)responseObject;
            NSMutableArray *curList = [NSMutableArray arrayWithArray:model.focusData[@"list"]];
            NSMutableArray *nextPageList = (NSMutableArray *)dic[@"list"];
            if (nextPageList.count)
            {
                [curList addObjectsFromArray:(NSArray *)dic[@"list"]];
                model.focusData[@"list"] = curList;
                model.focusDataPage++;
                model.totalListCount = curList.count;
                [self.focusTableView reloadData];
            }
            [SVProgressHUD dismiss];
            [self.focusTableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [self.focusTableView.mj_footer endRefreshing];
    }];
}


#pragma mark - table delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView)
    {
        return self.categoryModels.count;
    }else{
        NSMutableDictionary *focusDic = curSelectedCategoryModel.focusData;
        if (focusDic)
        {
            NSMutableArray *focusDataArray = focusDic[@"list"];
            return focusDataArray.count;
        }
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        static NSString *cellID = @"categoryCell";
        BSFriendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell)
        {
            cell = [BSFriendCategoryCell new];
            cell.cellModel = self.categoryModels[indexPath.row];
        }
        return cell;
    }else{
        static NSString *focusCellID = @"focusCell";
        BSFriendsFocusCell *cell = [tableView dequeueReusableCellWithIdentifier:focusCellID];
        if (!cell)
        {
            cell = [[BSFriendsFocusCell alloc]init];
            NSMutableDictionary *focusDic = curSelectedCategoryModel.focusData;
            if (focusDic)
            {
                NSMutableArray *focusDataArray = focusDic[@"list"];
                NSMutableArray<BSFriendsFocusCellModel *> *focusModels = [BSFriendsFocusCellModel mj_objectArrayWithKeyValuesArray:focusDataArray];
                cell.model = focusModels[indexPath.row];
            }
        }
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView)
    {
        BSFriendCategoryCellModel *curModel = self.categoryModels[indexPath.row];
        if (curModel.focusData)
        {
            [self.focusTableView reloadData];
        }else{
            [self.focusTableView reloadData]; // 如果没有数据刷新清空页面
            [self requestFocusDataWithCategoryModel:curModel];
        }
    }else{ }
}



@end
