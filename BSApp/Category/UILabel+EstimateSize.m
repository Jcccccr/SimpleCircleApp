//
//  UILabel+EstimateSize.m
//  QiYiVideoPhonePlugin
//
//  Created by 鞠鑫 on 2019/8/7.
//  Copyright © 2019 iqiyi. All rights reserved.
//

#import "UILabel+EstimateSize.h"

@implementation UILabel (EstimateSize)


+ (CGSize)estimateSizeOfText:(NSString *)text withMaxWidth:(CGFloat)maxWidth font:(UIFont *)font LineSpace:(CGFloat)lineSpace
{
    NSMutableDictionary *attrDic = [NSMutableDictionary new];
    attrDic[NSFontAttributeName] = font;
    if (lineSpace > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpace];
        attrDic[NSParagraphStyleAttributeName] = paragraphStyle;
    }
    CGSize labelSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:attrDic
                                          context:nil].size;
    return labelSize;
}

@end
