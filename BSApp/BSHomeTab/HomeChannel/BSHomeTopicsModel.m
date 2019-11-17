//
//  BSHomeTopicsModel.m
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSHomeTopicsModel.h"
#import "UILabel+EstimateSize.h"
#import "BSContant.h"
#import "BSHeader.h"
#import "NSDate+BSExtention.h"

@implementation BSHomeTopicsModel
{
    CGFloat _cellHeight;
}


- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 微博的创建日期
    NSDate *createDate = [fmt dateFromString:_created_at];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { // 今年
        if ([createDate isYesterday]) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { // 今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前", (int)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%d分钟前", (int)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else { // 今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

- (CGFloat)cellHeight
{
    if (!self->_cellHeight)
    {
        CGSize titleSize = [UILabel estimateSizeOfText:self.text withMaxWidth:SCREEN_WIDTH - cellMargin * 4 font:[UIFont systemFontOfSize:15.] LineSpace:0];
        
        //判断当前是存在图片数据，防止内部除0错误
        if (self.image2.length || self.image1.length || self.image0.length)
        {
            CGFloat imageWidth = SCREEN_WIDTH - cellMarginHorizontal * 4;
            CGFloat prop = imageWidth / [self.width floatValue];
            CGFloat imageHeight = [self.height floatValue] * prop;
            if ([self.height floatValue] > topicImageMaxHeight)
            {
                imageHeight = topicImageBreakHeight;
            }
            self.cellImageFrame = CGRectMake(
                                             cellMarginHorizontal,
                                             topicTopBarHeight + titleSize.height + cellMargin * 2,
                                             imageWidth,
                                             imageHeight
                                             );
        }
        self ->_cellHeight = topicTopBarHeight + titleSize.height + topicBottomBarHeight + _cellImageFrame.size.height + cellMargin;
    }
    return self->_cellHeight;
}

@end
