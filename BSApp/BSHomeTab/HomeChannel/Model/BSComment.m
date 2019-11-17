//
//  BSComments.m
//  BSApp
//
//  Created by Johnson on 2019/11/10.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSComment.h"
#import "UILabel+EstimateSize.h"
#import "BSContant.h"
#import "BSHeader.h"
#import "NSDate+BSExtention.h"


@implementation BSComment
{
    CGFloat _commentCellHeight;
}

- (CGFloat)commentCellHeight
{
    if (!self->_commentCellHeight)
    {
        CGSize contentSize = [UILabel estimateSizeOfText:self.content withMaxWidth:SCREEN_WIDTH - cellMargin * 2 - 60 font:[UIFont systemFontOfSize:12] LineSpace:0];
        _commentCellHeight = contentSize.height + 50.0 + commentCellMargin * 2;
    }
    return _commentCellHeight;
}


- (NSString *)formatCommentTime
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createDate = [fmt dateFromString:_ctime];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
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




@end
