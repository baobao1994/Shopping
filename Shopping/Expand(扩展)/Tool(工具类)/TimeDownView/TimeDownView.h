//
//  TimeDownView.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeDownView : UIView

@property (nonatomic, copy) void (^didCountDown)(void);
@property (nonatomic, strong) UIButton *timeButton;
@property (nonatomic, assign) NSInteger time;

@end
