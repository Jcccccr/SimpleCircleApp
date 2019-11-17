//
//  AppDelegate.m
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "AppDelegate.h"
#import "BSTabBarController.h"
#import "BSTopStatusBarWIndow.h"
#import "BSHeader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tabbarVC = [BSTabBarController new];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
