//
//  BSFriendCategoryCellModel.h
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSFriendCategoryCellModel : NSObject

@property (nonatomic, strong) NSString *count;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableDictionary *focusData;

@property (nonatomic, assign) NSInteger focusDataPage;

@property (nonatomic, assign) NSInteger totalListCount;

@end

NS_ASSUME_NONNULL_END
