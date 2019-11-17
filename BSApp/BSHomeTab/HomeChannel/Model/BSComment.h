//
//  BSComments.h
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSUser.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSComment : NSObject

@property (nonatomic, strong) BSUser *user;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *ctime;

@property (nonatomic, copy) NSString *like_count;

@property (nonatomic, copy) NSString *formatCommentTime;

@property (nonatomic, assign, readonly) CGFloat commentCellHeight;

@end

NS_ASSUME_NONNULL_END
