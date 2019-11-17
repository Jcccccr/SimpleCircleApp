//
//  BSUser.h
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSUser : NSObject

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *total_cmt_like_count;

@property (nonatomic, copy) NSString *personal_page;

@end

NS_ASSUME_NONNULL_END
