//
//  BSHomeTopicsViewController.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum {
    TopicTypeAll      = 1,
    TopicTypePictures = 10,
    TopicTypejokes    = 29,
    TopicTypeAudios   = 31,
    TopicTypeVideos   = 41
} TopicType;

@interface BSHomeTopicsViewController : UIViewController

@property (nonatomic, assign) TopicType topicType;

@end

NS_ASSUME_NONNULL_END
