//
//  UIImage+circularImage.h
//  BSApp
//
//  Created by Johnson on 2019/11/17.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (circularImage)

- (UIImage *)circularImage;

- (UIImage *)circularImageWithBorderWidth:(CGFloat) borderWidth borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
