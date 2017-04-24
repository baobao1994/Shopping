//
//  UserManager.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoModel;
@class SystemInfoModel;

@interface UserManager : NSObject

@property (nonatomic, strong) UserInfoModel *userInfo;
@property (nonatomic, strong) SystemInfoModel *systemInfo;

+ (UserManager *)shareInstance;
- (void)saveUserInfo:(UserInfoModel *)userInfo;
- (void)saveUserInfo;
- (void)deleteUser;

- (void)saveSystemInfo:(SystemInfoModel *)systemInfo;
- (void)saveSystemInfo;

@end
