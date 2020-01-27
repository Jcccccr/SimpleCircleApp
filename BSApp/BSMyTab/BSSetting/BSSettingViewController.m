//
//  BSSettingViewController.m
//  BSApp
//
//  Created by Johnson on 2020/1/27.
//  Copyright © 2020 Johnson. All rights reserved.
//

#import "BSSettingViewController.h"
#import "SDImageCache.h"

@interface BSSettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *settingTableView;

@end

@implementation BSSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settingTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.settingTableView.dataSource = self;
    self.settingTableView.delegate = self;
    [self.view addSubview:self.settingTableView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"缓存";
    }
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"清除缓存";
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat size = [[SDImageCache sharedImageCache]totalDiskSize];
            CGFloat MSize = size / 1000.0 / 1000.0;
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存（当前缓存:%.2fM）", MSize];
        });
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        [[SDImageCache sharedImageCache] clearMemory];
        UITableViewCell *curCell = [tableView cellForRowAtIndexPath:indexPath];
        CGFloat size = [[SDImageCache sharedImageCache]totalDiskSize];
        CGFloat MSize = size / 1000.0 / 1000.0;
        curCell.textLabel.text = [NSString stringWithFormat:@"清除缓存（当前缓存:%.2fM）", MSize];
    }
}

@end
