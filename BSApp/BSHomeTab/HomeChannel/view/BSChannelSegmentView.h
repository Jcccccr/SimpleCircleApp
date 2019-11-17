//
//  BSChannelSegmentView.h
//  BSApp
//
//  Created by Johnson on 2019/10/20.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^segmentTitleClickBlock)(UIButton *titleLabelBtn, NSInteger index);

@interface BSChannelSegmentView : UIView

@property (nonatomic, strong) NSArray <NSString *> *channelTitles;

@property (nonatomic, strong) UIColor *nomalColor;

@property (nonatomic, strong) UIColor *seletedColor;

@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, copy) segmentTitleClickBlock clickBlok;


@end

NS_ASSUME_NONNULL_END
