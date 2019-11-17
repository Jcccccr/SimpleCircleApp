//
//  BSLoginTextField.m
//  BSApp
//
//  Created by Johnson on 2019/10/20.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import "BSLoginTextField.h"
#import <objc/runtime.h>

@implementation BSLoginTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i++)
    {
        Ivar ivar = *(ivars + i);
//        NSLog(@"%s", ivar_getName(ivar));
    }
    free(ivars);
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    UILabel *placeHolderLabel = [self valueForKeyPath:@"_placeholderLabel"];
//    placeHolderLabel.textColor = [UIColor redColor];
}

@end
