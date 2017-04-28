//
//  ConstString.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "ConstString.h"

@implementation ConstString

#pragma mark - System

NSString * const BaiduMapKey = @"W9qfPDQ0PRjNaGdBfI86SXPitQhuHKyt";
NSString * const SMSModelNameKey = @"shopping";
NSString * const SystemTable = @"System";
NSString * const UserTable = @"User";
NSString * const AddressTable = @"Address";
NSString * const FoodcategoryTable = @"Foodcategory";
NSString * const FoodCollecTable = @"FoodCollec";
NSString * const ObjectIdKey = @"objectId";
NSString * const SystemServiceTelKey = @"service_tel";
NSString * const SystemOpenTimeKey = @"open_time";
NSString * const SystemIsOpenKey = @"is_open";

#pragma mark - UserInfo

NSString * const UserObjectIdKey = @"user_objectId";
NSString * const UserNameKey = @"name";
NSString * const UserImageNameKey = @"imageName";
NSString * const UserTelePhoneKey = @"telephone";
NSString * const UserBalanceKey = @"balance";
NSString * const UserCouponKey = @"coupon";
NSString * const UserIntegralKey = @"integral";
NSString * const UserPasswordKey = @"password";
NSString * const UserIsRememberKey = @"is_remember";
NSString * const UserAddressKey = @"address";
NSString * const UserDetailAddressKey = @"detail_address";
NSString * const UserSexKey = @"sex";

#pragma mark - Address

NSString * const AddressLatitudeKey = @"latitude";
NSString * const AddressLongitudeKey = @"longitude";

#pragma mark - FoodCollec

NSString * const FoodcategoryIdKey = @"foodcategory_id";
NSString * const FoodCollecIdKey = @"food_id";
NSString * const FoodCollecNameKey = @"name";
NSString * const FoodCollecImageNameKey = @"imageName";
NSString * const FoodCollecPriceKey = @"price";
NSString * const FoodCollecSellCountKey = @"sell_count";

#pragma mark - FoodCategory

NSString * const FoodCategoryIdKey = @"food_id";
NSString * const FoodCategoryNameKey = @"name";
NSString * const FoodCategoryImageNameKey = @"imageName";
NSString * const FoodCategoryListKey = @"list";

#pragma mark - Tips

NSString * const ErrorTipsNoNetwork = @"网络连接错误，请稍后重试";

#pragma mark - Scrollow

NSString * const kIsCanScroll = @"isCanScroll";
NSString * const kCanScroll = @"canScroll";
NSString * const kNoScroll = @"noScroll";
NSString * const kGoTopNotificationName = @"goTop";
NSString * const kLeaveTopNotificationName = @"leaveTop";

#pragma mark - Cache

NSString * const UserInfoCacheFile = @"cacheFile";
NSString * const UserInfoCache = @"userInfoCache";
NSString * const SystemInfoCache = @"systemInfoCache";
NSString * const LogoCache = @"logoCache.png";

@end
