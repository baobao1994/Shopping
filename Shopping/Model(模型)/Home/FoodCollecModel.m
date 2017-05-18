//
//  FoodCollecModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodCollecModel.h"
#import "ConstString.h"
#import "CartOrderModel.h"

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

- (id)initWithCartOrderModel:(CartOrderModel *)CartOrderModel {
    if (self = [super init]) {
        self.foodId = CartOrderModel.foodId;
        self.name = CartOrderModel.name;
        self.imageUrl = CartOrderModel.imageUrl;
        self.price = CartOrderModel.price;
        self.isCoupon = CartOrderModel.isCoupon;
        self.couponPrice = CartOrderModel.couponPrice;
        self.couponCount = CartOrderModel.couponCount;
    }
    return self;
}

@end
