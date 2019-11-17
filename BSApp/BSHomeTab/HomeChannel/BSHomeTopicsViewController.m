//
//  BSHomeTopicsViewController.m
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeTopicsViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "BSHomeTopicsModel.h"
#import "BSHomeTopicsCell.h"
#import "MJExtension.h"
#import "BSHeader.h"
#import "BSContant.h"
#import "MJRefresh.h"
#import "BSTopicPictureShowVIewController.h"
#import "BSCommonentsViewController.h"
#import "BSNewTabViewController.h"
#import "UIView+Tools.h"

@interface BSHomeTopicsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<BSHomeTopicsModel *> *topicModels;

@property (nonatomic, assign) NSInteger lastPage;

@property (nonatomic, copy) NSString *maxTime;

@property (nonatomic, strong) NSMutableDictionary *curRequestParams; // 记录最近一次请求的参数，用于校验并滤除不必要的回调刷新

@end

@implementation BSHomeTopicsViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(SegmentHeight, 0, topicBottomBarHeight, 0);
        _tableView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - SegmentHeight - topicBottomBarHeight);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray<BSHomeTopicsModel *> *)topicModels
{
    if (!_topicModels)
    {
        _topicModels = [NSMutableArray array];
    }
    return _topicModels;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = BSGlobalColor;
    self.tableView.backgroundColor = BSGlobalColor;
    [self setupRefresh];
    [self.tableView.mj_header beginRefreshing];
    [self setupNotification];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
}


- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabbarSingleClick) name:BSTabBarItemDidSingleClickNotifiaction object:nil];
}

- (void)headRefresh
{
    [self loadNewData];
}

- (void)footRefresh
{
    [self loadMoreData];
}

- (NSString *)aParamStr
{
    return [self.parentViewController isKindOfClass:[BSNewTabViewController class]] ? @"newlist" : @"list";
}

- (void)loadNewData
{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *requestURLStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self aParamStr];
    params[@"c"] = @"data";
    params[@"type"] = [NSString stringWithFormat:@"%u",self.topicType];
    self.curRequestParams = params;
    
    [manager GET:requestURLStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.tableView.mj_header endRefreshing];
        if (self.curRequestParams == params)
        {
            self.lastPage = 0;
            NSMutableDictionary *dic = (NSMutableDictionary *)responseObject;
            NSArray *keyValueArray = (NSArray *)dic[@"list"];
            NSDictionary *infoDic = dic[@"info"];
            self.maxTime = infoDic[@"maxtime"];
            self.topicModels = [BSHomeTopicsModel mj_objectArrayWithKeyValuesArray:keyValueArray];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}


- (void)loadMoreData
{
    self.lastPage++;
    
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *requestURLStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = [self aParamStr];
    params[@"c"] = @"data";
    params[@"type"] = [NSString stringWithFormat:@"%u",self.topicType];
    params[@"page"] = @(self.lastPage);
    params[@"maxtime"] = self.maxTime;
    self.curRequestParams = params;
    [manager GET:requestURLStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        if (params == self.curRequestParams)
        {
            NSMutableDictionary *dic = (NSMutableDictionary *)responseObject;
            NSArray *keyValueArray = (NSArray *)dic[@"list"];
            NSDictionary *infoDic = dic[@"info"];
            self.maxTime = infoDic[@"maxtime"];
            NSMutableArray<BSHomeTopicsModel *> *newModelArray = [BSHomeTopicsModel mj_objectArrayWithKeyValuesArray:keyValueArray];
            [self.topicModels addObjectsFromArray:newModelArray];
            [self.tableView reloadData];
        }else{
            self.lastPage--;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.lastPage--;
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.topicModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSHomeTopicsModel *model = self.topicModels[indexPath.row];
    CGFloat cellHeight = model.cellHeight;
    NSLog(@"%f", cellHeight);
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSHomeTopicsCell *cell = [BSHomeTopicsCell cellWithTableView:tableView];
    cell.model = self.topicModels[indexPath.row];
    // 点击事件统一处理
    cell.eventBlock = ^(cellEventType type) {
        switch (type) {
            case cellEventTypeGetAllImage:
                [self jumpToPictureShowVCWithModel:cell.model];
                break;
            case cellEventTypeDianzan:
                
                break;
            case cellEventTypeHeaderImgClick:
                
                break;
            case cellEventTypeCai:
                
                break;
            case cellEventTypeCommon:
                
                break;
            case cellEventTypeExport:
                
                break;
            default:
                break;
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommonentsViewController *userCommonentsVC = [[BSCommonentsViewController alloc]init];
    userCommonentsVC.topicModel = self.topicModels[indexPath.row];
    [self.navigationController pushViewController:userCommonentsVC animated:YES];
}


- (void)jumpToPictureShowVCWithModel:(BSHomeTopicsModel *)cellModel;
{
    BSTopicPictureShowVIewController *vc = [[BSTopicPictureShowVIewController alloc]init];
    [self presentViewController:vc animated:YES completion:^{
        vc.model = cellModel;
    }];
}


- (void)tabbarSingleClick
{
    // 判断自己view是不是可见的然后再刷新数据
    if ([self.view isVisibleOnKeyWindow])
    {
        [self.tableView.mj_header beginRefreshing];
    }
}


@end
