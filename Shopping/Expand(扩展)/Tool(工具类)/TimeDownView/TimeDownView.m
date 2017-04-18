//
//  TimeDownView.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "TimeDownView.h"
#import "UIButton+Addition.h"
#import "UIImage+Addition.h"

@interface TimeDownView()

@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

@end

@implementation TimeDownView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        _time = 60;
        _timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_timeButton setRoundCorner:5];
        [_timeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_timeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_timeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_timeButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        _timeButton.enabled = YES;
        [self refreshButtonWidth];
        [self addSubview:_timeButton];
    }
    return self;
}

- (void)refreshButtonWidth {
    CGFloat width = 0;
    if (_timeButton.enabled) {
        width = 80;
    } else {
        width = 120;
    }
    _timeButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    _timeButton.bounds = CGRectMake(0, 0, width, 40);
    //每次刷新，保证区域正确
    [_timeButton setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor] andSize:_timeButton.frame.size] forState:UIControlStateNormal];
    [_timeButton setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] andSize:_timeButton.frame.size] forState:UIControlStateDisabled];
}

- (void)btnAction:(UIButton *)sender {
    _timeButton.enabled = NO;
    [self refreshButtonWidth];
    [_timeButton setTitle:[NSString stringWithFormat:@"获取验证码(%zi)", _time] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo:nil repeats:YES];
    self.didCountDown();
}

- (void)timeDown {
    _time --;
    if (_time == 0) {
        [_timeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        _timeButton.enabled = YES;
        [self refreshButtonWidth];
        INVALIDATE_TIMER(_timer);
        _time = 60;
        return;
    }
    [_timeButton setTitle:[NSString stringWithFormat:@"获取验证码(%zi)", _time] forState:UIControlStateNormal];
}

@end
