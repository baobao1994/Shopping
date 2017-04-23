//
//  MBProgrossManager.h
//  RoadRescueApp
//
//  Created by yh on 16/7/9.
//  Copyright © 2016年 cuicuiTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

typedef void (^HudDidHidden)();

@interface MBProgrossManager : NSObject<MBProgressHUDDelegate>{
    HudDidHidden hudDidHidden;
    BOOL noNeedCallBack;
}

+ (MBProgrossManager *)shareInstance;
-(MBProgressHUD *)showOnlyText:(NSString *)text  HudHiddenCallBack:(HudDidHidden)hudHiddenCallBack;
-(MBProgressHUD *)ShowWaitingViewWithText:(NSString *)text;

@end
