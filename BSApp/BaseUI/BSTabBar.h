//
//  BSTabBar.h
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^tabbarPulishClickBlock)(void);

@interface BSTabBar : UITabBar

@property (nonatomic, copy) tabbarPulishClickBlock publishBlock;

@end

NS_ASSUME_NONNULL_END
