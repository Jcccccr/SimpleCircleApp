//
//  UILabel+EstimateSize.h
//  QiYiVideoPhonePlugin
//
//  Created by 鞠鑫 on 2019/8/7.
//  Copyright © 2019 iqiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (EstimateSize)

+ (CGSize)estimateSizeOfText:(NSString *)text withMaxWidth:(CGFloat)maxWidth font:(UIFont *)font LineSpace:(CGFloat)lineSpace;

@end

NS_ASSUME_NONNULL_END
