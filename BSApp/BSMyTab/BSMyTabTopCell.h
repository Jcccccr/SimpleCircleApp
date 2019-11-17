//
//  BSMyTabTopCell.h
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSMyTabTopCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

+ (instancetype)cellWithTableView:(UITableView *)tableView text:(NSString *)title;

@property (nonatomic, copy) NSString *contentText;

@end

NS_ASSUME_NONNULL_END
