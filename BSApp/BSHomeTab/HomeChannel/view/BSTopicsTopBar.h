//
//  BSTopicsTopBar.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^topBarModeBtnClickBlock)(UIButton *moreBtn);

@interface BSTopicsTopBar : UIView

@property (nonatomic, copy) NSString *nameImageUrl;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, weak) topBarModeBtnClickBlock block;

@end

NS_ASSUME_NONNULL_END
