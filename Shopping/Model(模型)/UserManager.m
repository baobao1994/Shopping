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
#import "SystemInfoModel.h"
#import "BannerModel.h"
#import "FoodCategoryModel.h"

@implementation UserManager

- (id)init {
    if (self = [super init]) {
        NSDictionary *userDic = [self getUserDicFromFile];
        self.userInfo = [userDic objectForKey:UserInfoCache];
        self.systemInfo = [userDic objectForKey:SystemInfoCache];
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

- (void)saveBannerInfo:(BannerModel *)bannerInfo {
    self.bannerInfo = bannerInfo;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableDictionary *bannerDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if (bannerInfo != nil) {
        [bannerDic setObject:bannerInfo forKey:BannerInfoCache];
    }
    [NSKeyedArchiver archiveRootObject:bannerDic toFile:cachePath];
}

- (void)saveBannerInfo {
    [self saveBannerInfo:_bannerInfo];
}

- (void)saveFoodCategoryInfo:(FoodCategoryModel *)foodCategoryInfo {
    self.foodCategoryInfo = foodCategoryInfo;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableDictionary *foodCategoryDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if (foodCategoryInfo != nil) {
        [foodCategoryDic setObject:foodCategoryInfo forKey:FoodCategoryInfoCache];
    }
    [NSKeyedArchiver archiveRootObject:foodCategoryDic toFile:cachePath];
}

- (void)saveFoodCategoryInfo {
    [self saveFoodCategoryInfo:_foodCategoryInfo];
}

- (void)saveSystemInfo {
    [self saveSystemInfo:_systemInfo];
}

- (void)saveSystemInfo:(SystemInfoModel *)systemInfo {
    self.systemInfo = systemInfo;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if (systemInfo != nil) {
        [userDic setObject:systemInfo forKey:SystemInfoCache];
    }
    [NSKeyedArchiver archiveRootObject:userDic toFile:cachePath];
}
/*
 - (void)saveUserInfo:(UserInfo *)userInfo bankInfo:(BankCard *)bank userIntegral:(UserIntegral *)userIntegral signInInfo:(SignIn *)signIn {
 NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
 NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithCapacity:2];
 if (userInfo != nil) {
 [userDic setObject:userInfo forKey:UserInfoCache];
 }
 if (bank != nil) {
 [userDic setObject:bank forKey:BankInfoCache];
 }
 if (userIntegral != nil) {
 [userDic setObject:userIntegral forKey:UserIntegralInfoCache];
 }
 if (signIn != nil) {
 [userDic setObject:signIn forKey:SignInInfoCache];
 }
 [NSKeyedArchiver archiveRootObject:userDic toFile:cachePath];
 }
*/

#pragma mark - Private Method

- (NSDictionary *)getUserDicFromFile {
    NSDictionary *cacheDic = nil;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableData *cacheData = [[NSMutableData alloc] initWithContentsOfFile:cachePath];
    if (cacheData != nil) {
        cacheDic = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    }
    return cacheDic;
}

@end
