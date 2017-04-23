//
//  PlaceBubbleView.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PlaceBubbleView.h"

@implementation PlaceBubbleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PlaceBubbleView" owner:self options:nil] firstObject];
        self.frame = frame;
    }
    return self;
}

- (IBAction)didSelectSureBtn:(UIButton *)sender {
    self.didSurePlace();
}


@end
