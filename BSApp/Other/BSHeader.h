//
//  BSHeader.h
//  BSApp
//
//  Created by Johnson on 2019/10/5.
//  Copyright © 2019 Johnson. All rights reserved.
//

#ifndef BSHeader_h
#define BSHeader_h

#import "UIResponder+BSEventChain.h"

#define BSRGBAColor(r,g,b,a)  ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)])

#define BSGlobalColor BSRGBAColor(229,229,229,1.0)

#define BSGlobalYellowColor BSRGBAColor(234,178,48,1.0)

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height

#endif /* BSHeader_h */
