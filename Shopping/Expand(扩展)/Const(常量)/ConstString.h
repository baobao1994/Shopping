//
//  ConstString.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConstString : NSObject

#pragma mark - System

extern NSString * const BaiduMapKey;
extern NSString * const SMSModelNameKey;
extern NSString * const SystemTable;
extern NSString * const UserTable;
extern NSString * const AddressTable;
extern NSString * const ObjectIdKey;
extern NSString * const SystemServiceTelKey;
extern NSString * const SystemOpenTimeKey;
extern NSString * const SystemIsOpenKey;

#pragma mark - UserInfo

extern NSString * const UserObjectIdKey;
extern NSString * const UserNameKey;
extern NSString * const UserImageNameKey;
extern NSString * const UserTelePhoneKey;
extern NSString * const UserBalanceKey;
extern NSString * const UserCouponKey;
extern NSString * const UserIntegralKey;
extern NSString * const UserPasswordKey;
extern NSString * const UserIsRememberKey;
extern NSString * const UserAddressKey;
extern NSString * const UserDetailAddressKey;
extern NSString * const UserSexKey;

#pragma mark - Address

extern NSString * const AddressLatitudeKey;
extern NSString * const AddressLongitudeKey;

#pragma mark - Tips

extern NSString * const ErrorTipsNoNetwork;

#pragma mark - Scrollow

extern NSString * const kIsCanScroll;
extern NSString * const kCanScroll;
extern NSString * const kNoScroll;
extern NSString * const kGoTopNotificationName;
extern NSString * const kLeaveTopNotificationName;

#pragma mark - Cache
extern NSString * const UserInfoCacheFile;
extern NSString * const UserInfoCache;
extern NSString * const SystemInfoCache;
extern NSString * const LogoCache;

@end
