//
//  BSHomeTopicsCell.h
//  BSApp
//
//  Created by Johnson on 2019/10/27.
//  Copyright © 2019 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    
    cellEventTypeGetAllImage,
    
    cellEventTypePlayVideo,
    
    cellEventTypePlayAudio,
    
    cellEventTypeDianzan,
    
    cellEventTypeCai,
    
    cellEventTypeCommon,
    
    cellEventTypeHeaderImgClick,
    
    cellEventTypeExport
    
}cellEventType;

typedef void(^cellEventHandlerBlock)(cellEventType type);

@class BSHomeTopicsModel;
@interface BSHomeTopicsCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) BSHomeTopicsModel *model;

@property (nonatomic, copy) cellEventHandlerBlock eventBlock;

@end

NS_ASSUME_NONNULL_END
