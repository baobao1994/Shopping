//
//  CATransition+Addition.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

typedef NS_ENUM(NSInteger, SubType) {
    SubTypeOfTop = 0,
    SubTypeOfBottom,
    SubTypeOfLeft,
    SubTypeOfRight,
};

@interface CATransition (Addition)

+ (void)setAnimationType:(NSString *)type duration:(CGFloat)duration subtype:(SubType)subtype;

@end
