//
//  MyFooterview.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyFooterview.h"

@implementation MyFooterview

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyFooterview" owner:self options:nil] firstObject];
    }
    return self;
}

@end
