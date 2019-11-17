//
//  BSTopicsBottomBar.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    BottomBarBtnTagGiveLike = 0,
    BottomBarBtnTagDissLike,
    BottomBarBtnTagForwarding,
    BottomBarBtnTagComments
}BottomBarBtnTag;

typedef void(^BottomBarClickBlock)(UIButton* ckickBtn, BottomBarBtnTag clickTag);

@interface BSTopicsBottomBar : UIView

@property (nonatomic, assign) NSInteger giveLike;

@property (nonatomic, assign) NSInteger dissLike;

@property (nonatomic, assign) NSInteger forwarding;

@property (nonatomic, assign) NSInteger comments;

@property (nonatomic, assign) BottomBarBtnTag btnTag;

@property (nonatomic, weak) BottomBarClickBlock clickBlock;
@end

NS_ASSUME_NONNULL_END
