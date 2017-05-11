//
//  FoodCollecModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodCollecModel.h"
#import "ConstString.h"
#import "OrderModel.h"

@implementation FoodCollecModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.foodId = [dic objectForKey:FoodCollecIdKey];
        self.name = [dic objectForKey:FoodCollecNameKey];
        self.imageUrl = [dic objectForKey:FoodCollecImageUrlKey];
        self.price = [dic objectForKey:FoodCollecPriceKey];
        self.sellCount = [dic objectForKey:FoodCollecSellCountKey];
        self.type = [dic objectForKey:FoodCollecTypeKey];
        self.foodType = [dic objectForKey:FoodCollecFoodTypeKey];
        self.foodSecType = [dic objectForKey:FoodCollecFoodSecTypeKey];
        self.isCoupon = [[dic objectForKey:FoodCollecIsCouponKey] boolValue];
        self.couponPrice = [dic objectForKey:FoodCollecCouponPriceKey];
        self.couponCount = [[dic objectForKey:FoodCollecCouponCountKey] integerValue];
    }
    return self;
}

- (id)initWithOrderModel:(OrderModel *)orderModel {
    if (self = [super init]) {
        self.foodId = orderModel.foodId;
        self.name = orderModel.name;
        self.imageUrl = orderModel.imageUrl;
        self.price = orderModel.price;
        self.isCoupon = orderModel.isCoupon;
        self.couponPrice = orderModel.couponPrice;
        self.couponCount = orderModel.couponCount;
    }
    return self;
}

@end
