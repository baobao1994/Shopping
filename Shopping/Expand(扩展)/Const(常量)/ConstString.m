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
NSString * const UserTable = @"User";
NSString * const ObjectIdKey = @"objectId";

#pragma mark - UserInfo

NSString * const UserNameKey = @"user_name";
NSString * const UserImageNameKey = @"user_imageName";
NSString * const UserTelePhoneKey = @"user_telephone";
NSString * const UserBalanceKey = @"user_balance";
NSString * const UserCouponKey = @"user_coupon";
NSString * const UserIntegralKey = @"user_integral";
NSString * const UserPasswordKey = @"user_password";
NSString * const UserIsRememberKey = @"user_is_remember";
NSString * const UserAddressKey = @"user_address";
NSString * const UserDetailAddressKey = @"user_detail_address";
NSString * const UserSexKey = @"user_sex";

#pragma mark - Address

NSString * const AddressLatitudeKey = @"address_latitude";
NSString * const AddressLongitudeKey = @"address_longitude";

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

@end
