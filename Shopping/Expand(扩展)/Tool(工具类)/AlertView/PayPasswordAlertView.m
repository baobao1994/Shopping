//
//  PayPasswordAlertView.m
//  TigerLottery
//
//  Created by Legolas on 14/12/17.
//  Copyright (c) 2014年 adcocoa. All rights reserved.
//

#import "PayPasswordAlertView.h"
#import "PayPasswordView.h"
#import "UIView+NIB.h"
#import "UIView+Addtion.h"

@interface PayPasswordAlertView () <PayPasswordViewDelegate, CAAnimationDelegate>

@property (nonatomic, retain) UIWindow *keyWindow;
@property (nonatomic, retain) PayPasswordView *payPasswordView;

@end

@implementation PayPasswordAlertView

+ (PayPasswordAlertView *)shareInstance {
    static PayPasswordAlertView *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[PayPasswordAlertView alloc] init];
    });
    return _instance;
}

- (id)init {
    if (self = [super init]) {

        _keyWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _keyWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _keyWindow.windowLevel = UIWindowLevelAlert;
//        window.rootViewController = viewController;
        
//        BaseWebViewController *baseWebVC = [[BaseWebViewController alloc] initWithNibName:@"BaseWebViewController" bundle:nil url:kTigerNewsUrl title:@"资讯"];
//        _keyWindow.rootViewController = baseWebVC;
        UIView *bgView = [[UIView alloc] initWithFrame:_keyWindow.frame];
        bgView.backgroundColor = [UIColor blackColor];
        [_keyWindow addSubview:bgView];
        bgView.alpha = 0.5;
        
        _payPasswordView = [PayPasswordView loadFromNIB];
        _payPasswordView.delegate = self;
        [_payPasswordView setCornerRadius:10.0];
        _payPasswordView.center = CGPointMake(_keyWindow.frame.size.width / 2, 100 + _payPasswordView.center.y);
        [_payPasswordView.closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [_keyWindow addSubview:_payPasswordView];
    }
    return self;
}

#pragma mark - Public Method

- (void)showWithTitle:(NSString *)title {
    if (_keyWindow.hidden) {
        [self cleanAllWord];
        [_keyWindow makeKeyAndVisible];
        _keyWindow.hidden = NO;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
        animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.duration = 0.5;
        //    animation.delegate = self;
        //    [animation setValue:completion forKey:@"handler"];
        [_payPasswordView.layer addAnimation:animation forKey:@"bounce"];
        _payPasswordView.transform = CGAffineTransformMakeScale(1, 1);
        
        [_payPasswordView.titleLabel setText:title];
    }
}

- (void)close {
    if (!_keyWindow.hidden) {
        [_payPasswordView resignAllFirstResponder];
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        animation.values = @[@(1), @(1.2), @(0.01)];
        animation.keyTimes = @[@(0), @(0.4), @(1)];
        animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        animation.duration = 0.5;
        animation.delegate = self;
        //    [animation setValue:completion forKey:@"handler"];
        [_payPasswordView.layer addAnimation:animation forKey:@"bounce"];
        _payPasswordView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }
}

- (void)cleanAllWord {
    [_payPasswordView cleanAllWord];
}

- (void)setupErrorMessage:(NSString *)message {
    if (!_keyWindow.hidden) {
        [_payPasswordView.errorLabel setText:message];
    }
}

#pragma mark - PayPasswordViewDelegate

- (void)didEnterPayPassword:(NSString *)payPassword {
    DELEGATE_CALLBACK_ONE_PARAMETER(_delegate, @selector(didEnterPayPassword:), payPassword);
}

#pragma mark - CAAnimation delegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _keyWindow.hidden = YES;
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
}

@end
