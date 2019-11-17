//
//  BSHomeTopicsModel.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSHomeTopicsModel : NSObject

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *profile_image;

@property (nonatomic, copy) NSString *sina_v;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *love;

@property (nonatomic, copy) NSString *hate;

@property (nonatomic, copy) NSString *repost;

@property (nonatomic, copy) NSString *comment;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *image0;

@property (nonatomic, copy) NSString *image1;

@property (nonatomic, copy) NSString *image2;

@property (nonatomic, copy) NSString *videouri;

@property (nonatomic, copy) NSString *voiceuri;

@property (nonatomic, assign, readonly) CGFloat cellHeight;

@property (nonatomic, assign) CGRect cellImageFrame;



@end

NS_ASSUME_NONNULL_END
