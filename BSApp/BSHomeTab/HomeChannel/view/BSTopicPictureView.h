//
//  BSTopicPictureView.h
//  BSApp
//
//  Created by Johnson on 2019/11/2.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickToGetAllBlock)(NSString *imageUrlStr);

@class BSHomeTopicsModel;
@interface BSTopicPictureView : UIView

@property (nonatomic, strong) BSHomeTopicsModel *model;

@property (nonatomic, copy) clickToGetAllBlock clickBlock;

@end

NS_ASSUME_NONNULL_END
