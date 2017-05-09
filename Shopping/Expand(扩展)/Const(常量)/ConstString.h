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
extern NSString * const BmobKey;
extern NSString * const SMSModelNameKey;
extern NSString * const SystemTable;
extern NSString * const UserTable;
extern NSString * const AddressTable;
extern NSString * const FoodcategoryTable;
extern NSString * const FoodCollecTable;
extern NSString * const BannerTable;
extern NSString * const HomeFoodListTable;
extern NSString * const FoodDetailListTable;
extern NSString * const FoodSecTypeListTable;
extern NSString * const ObjectIdKey;
extern NSString * const SystemServiceTelKey;
extern NSString * const SystemOpenTimeKey;
extern NSString * const SystemHomeBottomTipKey;
extern NSString * const SystemIsOpenKey;
extern NSString * const CustomFontName;

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

#pragma mark - Banner

extern NSString * const BannerImageUrlKey;
extern NSString * const BannerNameKey;

#pragma mark - FoodList

extern NSString * const FoodListImageUrlKey;
extern NSString * const FoodListNameKey;
extern NSString * const FoodListTypeKey;

#pragma mark - FoodSecTypeList

extern NSString * const FoodSecTypeListFoodTypeKey;
extern NSString * const FoodSecTypeListNameKey;
extern NSString * const FoodSecTypeListTypeKey;

#pragma mark - Address

extern NSString * const AddressLatitudeKey;
extern NSString * const AddressLongitudeKey;

#pragma mark - FoodCollec

extern NSString * const FoodCollecIdKey;
extern NSString * const FoodCollecNameKey;
extern NSString * const FoodCollecImageUrlKey;
extern NSString * const FoodCollecPriceKey;
extern NSString * const FoodCollecSellCountKey;
extern NSString * const FoodCollecFoodTypeKey;
extern NSString * const FoodCollecTypeKey;
extern NSString * const FoodCollecFoodSecTypeKey;

#pragma mark - FoodCategory

extern NSString * const FoodCategoryIdKey;
extern NSString * const FoodCategoryNameKey;
extern NSString * const FoodCategoryImageUrlKey;
extern NSString * const FoodCategoryTypeKey;
extern NSString * const FoodCategoryFoodTypeKey;
extern NSString * const FoodCategoryFoodSecTypeKey;
extern NSString * const FoodCategoryListKey;

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
extern NSString * const BannerInfoCache;
extern NSString * const FoodCategoryInfoCache;
extern NSString * const LogoCache;

@end
