//
//  UIImage+originImage.m
//  LuckyTicket
//
//  Created by Johnson on 2019/7/28.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "UIImage+originImage.h"

@implementation UIImage (originImage)

+ (UIImage *)imageWithOriRenderingImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
