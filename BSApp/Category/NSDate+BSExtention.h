//
//  NSData+BSExtention.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (BSExtention)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;


@end

NS_ASSUME_NONNULL_END
