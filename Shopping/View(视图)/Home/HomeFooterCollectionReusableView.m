//
//  HomeFooterCollectionReusableView.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HomeFooterCollectionReusableView.h"

@implementation HomeFooterCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HomeFooterCollectionReusableView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

@end
