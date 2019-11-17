//
//  BSMenuBtn.m
//  BSApp
//
//  Created by Johnson on 2019/11/3.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSMenuBtn.h"
#import "UIView+Frame.h"

@implementation BSMenuBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(0, 0, self.width, self.width);
    
    self.titleLabel.frame = CGRectMake(0, self.width + 10, self.width, 30);
}

@end
