//
//  HomeHeaderCollectionReusableView.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HomeHeaderCollectionReusableView.h"
#import "AdPageView.h"
#import "BannerModel.h"

@interface HomeHeaderCollectionReusableView ()

@property (nonatomic, strong) AdPageView *adPageView;

@end

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
    _adPageView = [[AdPageView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 120 * UIScreenWidth / 320)];
    _adPageView.iDisplayTime = 5;
    _adPageView.pageControl.pageIndicatorTintColor = UIColorFromHexColor(0xcccccc);
    _adPageView.pageControl.currentPageIndicatorTintColor = UIColorFromHexColor(0xe73f40);
    [self addSubview:_adPageView];
}

- (void)setUpImage:(NSMutableArray *)imageArr {
    NSMutableArray *imageUrls = [[NSMutableArray alloc] init];
    for (BannerModel *bannerModel in imageArr) {
        [imageUrls addObject:bannerModel.imageUrl];
    }
    [_adPageView startAdsWithBlock:imageUrls block:^(NSInteger clickIndex){
        NSLog(@"点击 = %ld",clickIndex);
    }];
}

@end
