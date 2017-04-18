//
//  UserManager.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/18.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "UserManager.h"
#import "ConstString.h"
#import "UserInfoModel.h"

@implementation UserManager

- (id)init {
    if (self = [super init]) {
        NSDictionary *userDic = [self getUserDicFromFile];
        self.userInfo = [userDic objectForKey:UserInfoCache];
    }
    return self;
}

+ (UserManager *)shareInstance {
    static UserManager *_info;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _info = [[UserManager alloc] init];
    });
    return _info;
}

- (void)saveUserInfo {
    [self saveUserInfo:_userInfo];
}

- (void)saveUserInfo:(UserInfoModel *)userInfo {
    self.userInfo = userInfo;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if (userInfo != nil) {
        [userDic setObject:userInfo forKey:UserInfoCache];
    }
    [NSKeyedArchiver archiveRootObject:userDic toFile:cachePath];
}

- (void)deleteUser {
    self.userInfo = nil;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    DELETE_FILE(cachePath);
}

#pragma mark - Private Method

- (NSDictionary *)getUserDicFromFile {
    NSDictionary *userDic = nil;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableData *userData = [[NSMutableData alloc] initWithContentsOfFile:cachePath];
    if (userData != nil) {
        userDic = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return userDic;
}

@end
