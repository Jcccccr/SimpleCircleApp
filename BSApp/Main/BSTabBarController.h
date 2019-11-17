//
//  BSTabBarController.h
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BSTabBar;
@class UITabBarItem;
@protocol BSTabbarEventProtocal <NSObject>
- (void)tabbarItemSingleCkickWithTabbar:(BSTabBar *)tabbar singleClickItem:(UITabBarItem *)item;
@end

@interface BSTabBarController : UITabBarController



@end

NS_ASSUME_NONNULL_END
