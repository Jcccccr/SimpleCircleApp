//
//  UIResponder+BSEventChain.m
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "UIResponder+BSEventChain.h"

@implementation UIResponder (BSEventChain)

- (void)routerEventWithName:(NSString *)eventName sender:(id)sender userInfo:(NSDictionary *)userInfo
{
    [self.nextResponder routerEventWithName:eventName sender:sender userInfo:userInfo];
}

@end
