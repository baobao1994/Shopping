//
//  MBProgrossManager.m
//  RoadRescueApp
//
//  Created by yh on 16/7/9.
//  Copyright © 2016年 cuicuiTech. All rights reserved.
//

#import "MBProgrossManager.h"

@implementation MBProgrossManager

#define rootViewController [[UIApplication sharedApplication] keyWindow].rootViewController

+ (MBProgrossManager *)shareInstance {
    static MBProgrossManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (MBProgressHUD *)showOnlyText:(NSString *)text  HudHiddenCallBack:(HudDidHidden)hudHiddenCallBack {
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:rootViewController.view animated:YES];
    hudDidHidden = hudHiddenCallBack;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.delegate = self;
    [hud hide:YES afterDelay:1.5];
    return hud;
}

- (MBProgressHUD *)ShowWaitingViewWithText:(NSString *)text {
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:rootViewController.view animated:YES];
    hud.labelText = text;
    hud.delegate = self;
    noNeedCallBack = YES;
    return hud;
}

- (void)hudWasHidden:(MBProgressHUD *)hud {
    if (noNeedCallBack) {
        noNeedCallBack = NO;
        return;
    }
    if (hudDidHidden != nil) {
        hudDidHidden();
        hudDidHidden = nil;
    }
}

@end
