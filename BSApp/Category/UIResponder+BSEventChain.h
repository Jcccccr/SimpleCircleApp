//
//  UIResponder+BSEventChain.h
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (BSEventChain)

- (void)routerEventWithName:(NSString *)eventName sender:(id)sender userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
