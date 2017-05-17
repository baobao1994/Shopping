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
#import "IQKeyboardManager.h"
#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
#import "ScottAlertController.h"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@property (nonatomic, strong) UserManager *userManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
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
    [self initIQKeyboard];
    [self initJPush:application launchOptions:launchOptions];
    application.applicationIconBadgeNumber = 0;
    self.userManager = UserManagerInstance;
    if (!self.userManager.userInfo.isRemember || self.userManager.userInfo.userObjectId == nil) {
        [self.userManager deleteUser];
    }
    return YES;
}

- (void)initBmob {
    [Bmob registerWithAppKey:BmobKey];
}

- (void)initIQKeyboard {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.overrideKeyboardAppearance = YES;
    manager.shouldResignOnTouchOutside = YES;
}

- (void)initBaiduMap {
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定generalDelegate参数
    BOOL ret = [_mapManager start:BaiduMapKey generalDelegate:nil];
    if (ret) {
        NSLog(@"百度引擎设置成功！");
    }
}

- (void)initJPush:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
//    [[UIApplication sharedApplication] unregisterForRemoteNotifications];//关闭通知
//    [[UIApplication sharedApplication] registerForRemoteNotifications];//开启通知
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:advertisingId];
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //注册自定义消息推送
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self
                      selector:@selector(networkDidReceiveMessage:)
                          name:kJPFNetworkDidReceiveMessageNotification
                        object:nil];
}

- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    [MBProgrossManagerInstance showOnlyText:[userInfo objectForKey:@"content"] HudHiddenCallBack:nil];
}

#pragma mark- JPUSHRegisterDelegate

//当应用在前台时，接收到通知消息首先会调用极光的这个代理
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]
        ]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
     // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {//前台
        completionHandler(UNNotificationPresentationOptionSound);
        [self showAlert:userInfo];
    }else if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {//后台
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    }else {//未启动
        completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    }
}

//点击通知进入
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        [self showAlert:userInfo];
    } else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    [JPUSHService resetBadge];
    completionHandler();  // 系统要求执行这个方法
}

- (void)showAlert:(NSDictionary *)userInfo {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"提示" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]];
    ScottAlertAction *action = [ScottAlertAction actionWithTitle:@"查看" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
        [JPUSHService resetBadge];
    }];
    [alertView addAction:action];
    ScottAlertAction *action1 = [ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
    }];
    [alertView addAction:action1];
    [ScottShowAlertView showAlertViewWithView:alertView backgroundDismissEnable:YES];
}

/** 远程通知回调函数，只要点击了远程推送的消息就会走这个方法 */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
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
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
