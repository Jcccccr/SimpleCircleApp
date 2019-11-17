//
//  BSCommonentsViewController.m
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSCommonentsViewController.h"
#import "BSHeader.h"
#import "BSContant.h"
#import "BSHomeTopicsCell.h"
#import "BSHomeTopicsModel.h"
#import "MJRefresh.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
#import "BSComment.h"
#import "MJExtension.h"
#import "BSCommentCell.h"

@interface BSCommonentsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *comnsTableView;

@property (nonatomic, strong) NSMutableArray  *hotCommonents;

@property (nonatomic, strong) NSMutableArray  *curCommonents;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BSCommonentsViewController

- (void)dealloc
{
    [self.manager invalidateSessionCancelingTasks:YES resetSession:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
}

- (void)commonInit
{
    self.comnsTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.comnsTableView.delegate = self;
    self.comnsTableView.dataSource = self;
    self.comnsTableView.backgroundColor = BSGlobalColor;
    self.comnsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.comnsTableView];
    [self setupHeaderView];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self loadNewCommonents];
}

- (void)setupRefresh
{
    self.comnsTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewCommonents)];
    self.comnsTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreCommonents)];
}


- (void)setupHeaderView
{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(commentCellMargin,
                                                                 commentCellMargin,
                                                                 SCREEN_WIDTH - commentCellMargin * 2,
                                                                 _topicModel.cellHeight - cellMargin)];
    headerView.backgroundColor = [UIColor whiteColor];
    BSHomeTopicsCell *curTopicCellView = [[BSHomeTopicsCell alloc]init];
    curTopicCellView.model = self.topicModel;
    [headerView addSubview:curTopicCellView];
    self.comnsTableView.tableHeaderView = headerView;
}

- (void)loadNewCommonents
{
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *requestURLStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.id;
    params[@"hot"] = @"1";
    [manager GET:requestURLStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.comnsTableView.mj_header endRefreshing];
        NSMutableDictionary *dict = (NSMutableDictionary *)responseObject;
        if (dict && dict.count)
        {
            NSArray *curComments = (NSArray *)dict[@"data"];
            NSArray *hotComments = (NSArray *)dict[@"hot"];
            self.curCommonents   = [BSComment mj_objectArrayWithKeyValuesArray:curComments];
            self.hotCommonents   = [BSComment mj_objectArrayWithKeyValuesArray:hotComments];
            [self.comnsTableView reloadData];
            self.page = 1;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}


- (void)loadMoreCommonents
{
    NSInteger nextPage = self.page + 1;
    BSComment *lastComment = self.curCommonents.lastObject;
    [SVProgressHUD show];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    NSString *requestURLStr = @"http://api.budejie.com/api/api_open.php";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicModel.id;
    params[@"lastcid"] = lastComment.id;
    params[@"page"] = @(nextPage);
    [manager GET:requestURLStr parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self.comnsTableView.mj_footer endRefreshing];
        NSMutableDictionary *dict = (NSMutableDictionary *)responseObject;
        if (dict && dict.count)
        {
            NSArray *moreData = (NSArray *)dict[@"data"];
            NSArray *moreComments = (NSArray *)[BSComment mj_objectArrayWithKeyValuesArray:moreData];
            [self.curCommonents addObjectsFromArray:moreComments];
            [self.comnsTableView reloadData];
            self.page = nextPage;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败，请检查网络"];
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return commentTableCellHeaderHeight;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.hotCommonents.count > 0 ? @"最热评论" : @"最新评论";
    }
    if (section == 1)
    {
        return @"最新评论";
    }
    return @"评论";
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.hotCommonents.count && self.curCommonents.count) {
        return 2;
    } else if (!self.hotCommonents.count && !self.curCommonents.count) {
        return 0;
    } else {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self commentsArrayWithSection:section].count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *comments = [self commentsArrayWithSection:indexPath.section];
    BSComment *commentModel = comments[indexPath.row];
    return commentModel.commentCellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommentCell *cell = [BSCommentCell cellWithTableView:tableView];
    NSMutableArray *comments = [self commentsArrayWithSection:indexPath.section];
    cell.commentModel = comments[indexPath.row];
    return cell;
}


- (NSMutableArray *)commentsArrayWithSection:(NSInteger)section
{
    NSMutableArray *comments = [NSMutableArray array];
    if (section == 0)
    {
        comments =  self.hotCommonents.count > 0 ? self.hotCommonents : self.curCommonents;
    }
    if (section == 1)
    {
        comments = self.curCommonents;
    }
    return comments;
}


@end
