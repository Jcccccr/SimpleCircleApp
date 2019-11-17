//
//  BSTopicAudioView.h
//  BSApp
//
//  Created by Johnson on 2019/11/9.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickToPlayAudioBlock)(NSString *videoUrl);

@class BSHomeTopicsModel;
@interface BSTopicAudioView : UIView

@property (nonatomic, strong) BSHomeTopicsModel *model;

@property (nonatomic, copy) clickToPlayAudioBlock playAudioBlock;

@end

NS_ASSUME_NONNULL_END
