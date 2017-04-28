//
//  AppDelegate.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "AppDelegate.h"
#import "SHTabbarController.h"
#import "ConstString.h"
#import "UserManager.h"
#import "UserInfoModel.h"

@interface AppDelegate ()

@property (nonatomic, strong) UserManager *userManager;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SHTabbarController *tabBarVc = [[SHTabbarController alloc] init];
    self.window.rootViewController = tabBarVc;
    
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    self.window.backgroundColor = UIColorFromHexColor(0XFFFFFF);
    [self.window makeKeyAndVisible];
    [self initBmob];
    [self initBaiduMap];
    self.userManager = UserManagerInstance;
    if (!self.userManager.userInfo.isRemember || self.userManager.userInfo.userObjectId == nil) {
        [self.userManager deleteUser];
    }
    return YES;
}

- (void)initBaiduMap {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:BaiduMapKey generalDelegate:nil];
    if (ret) {
        NSLog(@"百度引擎设置成功！");
    }
}

- (void)initBmob {
    [Bmob registerWithAppKey:@"32fbb0135e919115092c0e0850636a77"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
