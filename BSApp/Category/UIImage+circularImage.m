//
//  UIImage+circularImage.m
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "UIImage+circularImage.h"


@implementation UIImage (circularImage)

- (UIImage *)circularImage
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (UIImage *)circularImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nonnull UIColor *)borderColor
{
    CGSize size = CGSizeMake(self.size.width + 2 * borderWidth, self.size.height + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    [clipPath addClip];
    [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
