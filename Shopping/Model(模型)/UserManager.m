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
        NSDictionary *cacheDic = [self getCacheDicFromFile];
        self.bannerArrInfo = [[NSMutableArray alloc] init];
        self.foodCategoryArrInfo = [[NSMutableArray alloc] init];
        self.userInfo = [cacheDic objectForKey:UserInfoCache];
        self.systemInfo = [cacheDic objectForKey:SystemInfoCache];
        self.foodCategoryArrInfo = [cacheDic objectForKey:FoodCategoryInfoCache];
        self.bannerArrInfo = [cacheDic objectForKey:BannerInfoCache];
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
    [self saveUserInfo:userInfo bannerArrInfo:_bannerArrInfo foodCategoryArrInfo:_foodCategoryArrInfo systemInfo:_systemInfo];
}

- (void)deleteUser {
    self.userInfo.userObjectId = nil;
    [self saveUserInfo:_userInfo bannerArrInfo:_bannerArrInfo foodCategoryArrInfo:_foodCategoryArrInfo systemInfo:_systemInfo];
}

- (void)deleteCache {
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    DELETE_FILE(cachePath);
}

- (void)saveBannerArrInfo:(NSMutableArray *)bannerArrInfo {
    self.bannerArrInfo = bannerArrInfo;
    [self saveUserInfo:_userInfo bannerArrInfo:bannerArrInfo foodCategoryArrInfo:_foodCategoryArrInfo systemInfo:_systemInfo];
}

- (void)saveBannerArrInfo {
    [self saveBannerArrInfo:_bannerArrInfo];
}

- (void)saveFoodCategoryArrInfo:(NSMutableArray *)foodCategoryArrInfo {
    self.foodCategoryArrInfo = foodCategoryArrInfo;
    [self saveUserInfo:_userInfo bannerArrInfo:_bannerArrInfo foodCategoryArrInfo:foodCategoryArrInfo systemInfo:_systemInfo];
}

- (void)saveFoodCategoryArrInfo {
    [self saveFoodCategoryArrInfo:_foodCategoryArrInfo];
}

- (void)saveSystemInfo {
    [self saveSystemInfo:_systemInfo];
}

- (void)saveSystemInfo:(SystemInfoModel *)systemInfo {
    self.systemInfo = systemInfo;
    [self saveUserInfo:_userInfo bannerArrInfo:_bannerArrInfo foodCategoryArrInfo:_foodCategoryArrInfo systemInfo:systemInfo];
}

- (void)saveUserInfo:(UserInfoModel *)userInfo bannerArrInfo:(NSMutableArray *)bannerArrInfo foodCategoryArrInfo:(NSMutableArray *)foodCategoryArrInfo systemInfo:(SystemInfoModel *)systemInfo {
     NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
     NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithCapacity:4];
     if (userInfo != nil) {
         [cacheDic setObject:userInfo forKey:UserInfoCache];
     }
     if (bannerArrInfo.count) {
         [cacheDic setObject:bannerArrInfo forKey:BannerInfoCache];
     }
     if (foodCategoryArrInfo.count) {
         [cacheDic setObject:foodCategoryArrInfo forKey:FoodCategoryInfoCache];
     }
     if (systemInfo != nil) {
         [cacheDic setObject:systemInfo forKey:SystemInfoCache];
     }
     [NSKeyedArchiver archiveRootObject:cacheDic toFile:cachePath];
}

#pragma mark - Private Method

- (NSDictionary *)getCacheDicFromFile {
    NSDictionary *cacheDic = nil;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:UserInfoCacheFile];
    NSMutableData *cacheData = [[NSMutableData alloc] initWithContentsOfFile:cachePath];
    if (cacheData != nil) {
        cacheDic = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    }
    return cacheDic;
}

@end
