//
//  UIBarButtonItem+Navigation.h
//  BSApp
//
//  Created by Johnson on 2019/10/6.
//  Copyright © 2019 Johnson. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Navigation)

+ (instancetype)itemWithImage:(UIImage *)image
                selectedImage:(UIImage *)highlightImage
                       target:(id)target
                       action:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
