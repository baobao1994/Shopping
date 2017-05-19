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
NSString * const BmobKey = @"32fbb0135e919115092c0e0850636a77";
NSString * const JPushKey = @"ec6d482dd88a50296a01b33e";
NSString * const SMSModelNameKey = @"shopping";
NSString * const SystemTable = @"System";
NSString * const UserTable = @"User";
NSString * const AddressTable = @"Address";
NSString * const FoodcategoryTable = @"FoodCategory";
NSString * const FoodCollecTable = @"FoodCollec";
NSString * const BannerTable = @"Banner";
NSString * const HomeFoodListTable = @"HomeFoodList";
NSString * const FoodDetailListTable = @"FoodDetailList";
NSString * const FoodSecTypeListTable = @"FoodSecTypeList";
NSString * const OrderTable = @"Order";
NSString * const ObjectIdKey = @"objectId";
NSString * const CreatedAtKey = @"createdAt";
NSString * const SystemServiceTelKey = @"service_tel";
NSString * const SystemOpenTimeKey = @"open_time";
NSString * const SystemHomeBottomTipKey = @"home_bottom_tip";
NSString * const SystemIsOpenKey = @"is_open";
NSString * const SystemSendFreeDistanceKey = @"send_free_distance";
NSString * const SystemLimitSendPriceKey = @"limit_send_price";
NSString * const SystemBeginSendPriceKey = @"begin_send_price";
NSString * const CustomFontName = @"FZLBJW--GB1-0";

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

#pragma mark - Banner

NSString * const BannerImageUrlKey = @"image_url";
NSString * const BannerNameKey = @"name";

#pragma mark - FoodList

NSString * const FoodListImageUrlKey = @"image_url";
NSString * const FoodListNameKey = @"name";
NSString * const FoodListTypeKey = @"type";
NSString * const FoodListShowTypeKey = @"show_type";

#pragma mark - FoodSecTypeList

NSString * const FoodSecTypeListFoodTypeKey = @"food_type";
NSString * const FoodSecTypeListNameKey = @"name";
NSString * const FoodSecTypeListTypeKey = @"type";

#pragma mark - Address

NSString * const AddressLatitudeKey = @"latitude";
NSString * const AddressLongitudeKey = @"longitude";

#pragma mark - FoodCollec

NSString * const FoodCollecIdKey = @"food_id";
NSString * const FoodCollecNameKey = @"name";
NSString * const FoodCollecImageUrlKey = @"image_url";
NSString * const FoodCollecPriceKey = @"price";
NSString * const FoodCollecSellCountKey = @"sell_count";
NSString * const FoodCollecFoodTypeKey = @"food_type";
NSString * const FoodCollecTypeKey = @"type";
NSString * const FoodCollecFoodSecTypeKey = @"food_sec_type";
NSString * const FoodCollecIsCouponKey = @"is_coupon";
NSString * const FoodCollecCouponPriceKey = @"coupon_price";
NSString * const FoodCollecCouponCountKey = @"coupon_count";

#pragma mark - FoodCategory

NSString * const FoodCategoryIdKey = @"food_id";
NSString * const FoodCategoryNameKey = @"name";
NSString * const FoodCategoryImageUrlKey = @"image_url";
NSString * const FoodCategoryTypeKey = @"food_type";
NSString * const FoodCategoryFoodTypeKey = @"food_type";
NSString * const FoodCategoryFoodSecTypeKey = @"food_sec_type";
NSString * const FoodCategoryListKey = @"list";

#pragma mark - Order

NSString * const OrderFoodIdKey = @"food_id";
NSString * const OrderNameKey = @"name";
NSString * const OrderImageUrlKey = @"image_url";
NSString * const OrderPriceKey = @"price";
NSString * const OrderFoodPriceKey = @"food_price";
NSString * const OrderCountKey = @"count";
NSString * const OrderIsCouponKey = @"is_coupon";
NSString * const OrderCouponPriceKey = @"coupon_price";
NSString * const OrderCouponCountKey = @"coupon_count";
NSString * const OrderIsEvaluateKey = @"is_evaluate";
NSString * const OrderStatusKey = @"status";
NSString * const OrderListKey = @"order_list";
NSString * const OrderIsIntheShopKey = @"is_in_the_shop";
NSString * const OrderSendPriceKey = @"send_price";
NSString * const OrderAddressKey = @"address";

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
NSString * const OrderInfoCacheFile = @"orderCacheFile";
NSString * const UserInfoCache = @"userInfoCache";
NSString * const SystemInfoCache = @"systemInfoCache";
NSString * const BannerInfoCache = @"bannerInfoCache";
NSString * const OrderInfoCache = @"orderInfoCache";
NSString * const FoodCategoryInfoCache = @"foodCategoryInfoCache";
NSString * const LogoCache = @"logoCache.png";

@end
