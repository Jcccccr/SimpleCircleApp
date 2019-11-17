//
//  BSPushMenuView.h
//  BSApp
//
//  Created by Johnson on 2019/11/3.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^cancelBlock)(void);

@interface BSPushMenuView : UIView

@property (nonatomic, copy) cancelBlock cancelblock;

@end

NS_ASSUME_NONNULL_END
