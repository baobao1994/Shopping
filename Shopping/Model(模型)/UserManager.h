//
//  UserManager.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoModel;

@interface UserManager : NSObject

@property (nonatomic, strong) UserInfoModel *userInfo;

+ (UserManager *)shareInstance;
- (void)saveUserInfo:(UserInfoModel *)userInfo;
- (void)saveUserInfo;
- (void)deleteUser;

@end
