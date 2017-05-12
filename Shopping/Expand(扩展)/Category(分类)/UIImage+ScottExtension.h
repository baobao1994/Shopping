//
//  UIImage+ScottExtension.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ScottExtension)

/// 获取屏幕截图
///
/// @return 屏幕截图图像
+ (UIImage *)scott_screenShot;


/**
 *  生成一张高斯模糊的图片
 *
 *  @param image 原图
 *  @param blur  模糊程度 (0~1)
 *
 *  @return 高斯模糊图片
 */
+ (UIImage *)scott_blurImage:(UIImage *)image blur:(CGFloat)blur;

@end
