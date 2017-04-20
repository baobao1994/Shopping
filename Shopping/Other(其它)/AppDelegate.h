//
//  AppDelegate.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BMKMapManager *mapManager;

@end

