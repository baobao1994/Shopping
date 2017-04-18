//
//  CATransition+Addition.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "CATransition+Addition.h"

@implementation CATransition (Addition)

+ (void)setAnimationType:(NSString *)type duration:(CGFloat)duration subtype:(SubType)subtype {
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型
    animation.type = type;
    //设置动画时长
    animation.duration = duration;
    //设置运动的方向
    switch (subtype) {
        case SubTypeOfTop:
            animation.subtype =kCATransitionFromTop;
            break;
        case SubTypeOfBottom:
            animation.subtype =kCATransitionFromBottom;
            break;
        case SubTypeOfLeft:
            animation.subtype =kCATransitionFromLeft;
            break;
        case SubTypeOfRight:
            animation.subtype =kCATransitionFromRight;
            break;
        default:
            break;
    }
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
}

/*
 Fade = 1,                   //淡入淡出
 Push,                       //推挤
 Reveal,                     //揭开
 MoveIn,                     //覆盖
 Cube,                       //立方体
 SuckEffect,                 //吮吸
 OglFlip,                    //翻转
 RippleEffect,               //波纹
 PageCurl,                   //翻页
 PageUnCurl,                 //反翻页
 CameraIrisHollowOpen,       //开镜头
 CameraIrisHollowClose,      //关镜头
 CurlDown,                   //下翻页
 CurlUp,                     //上翻页
 FlipFromLeft,               //左翻转
 FlipFromRight,              //右翻转
 rippleEffect                //滴水效果
 suckEffect                  //收缩效果
 oglFlip                     //上下翻转效果
 */

@end
