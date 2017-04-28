//
//  HomeHeaderCollectionReusableView.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HomeHeaderCollectionReusableView.h"
#import "AdPageView.h"

@implementation HomeHeaderCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"HomeHeaderCollectionReusableView" owner:self options:nil] firstObject];
        self.frame = frame;
        [self setUpAdPageView];
    }
    return self;
}

- (void)setUpAdPageView {
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 120)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"h%d.jpg",i + 1]];
        [views addObject:imageView];
    }
    AdPageView *pageView = [[AdPageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 120)];
    pageView.iDisplayTime = 3;
    pageView.pageControl.pageIndicatorTintColor = UIColorFromHexColor(0xcccccc);
    pageView.pageControl.currentPageIndicatorTintColor = UIColorFromHexColor(0xe73f40);
    [pageView setupSubviews:views block:^(NSInteger clickIndex) {
    }];
    [self addSubview:pageView];
}

@end
