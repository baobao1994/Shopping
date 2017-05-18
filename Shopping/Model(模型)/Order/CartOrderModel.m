//
//  CartOrderModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "CartOrderModel.h"
#import "ConstString.h"

@implementation CartOrderModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.foodId = [dic objectForKey:ObjectIdKey];
        self.name = [dic objectForKey:OrderNameKey];
        self.imageUrl = [dic objectForKey:OrderImageUrlKey];
        self.price = [dic objectForKey:OrderPriceKey];
        self.foodPrice = [dic objectForKey:OrderFoodPriceKey];
        self.count = [[dic objectForKey:OrderCountKey] integerValue];
        self.isCoupon = [[dic objectForKey:OrderIsCouponKey] boolValue];
        self.couponPrice = [dic objectForKey:OrderCouponPriceKey];
        self.couponCount = [[dic objectForKey:OrderCouponCountKey] integerValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.foodId)) {
        [aCoder encodeObject:self.foodId forKey:ObjectIdKey];
    }
    if (!isEmptyString(self.name)) {
        [aCoder encodeObject:self.name forKey:OrderNameKey];
    }
    if (!isEmptyString(self.imageUrl)) {
        [aCoder encodeObject:self.imageUrl forKey:OrderImageUrlKey];
    }
    if (!isEmptyString(self.price)) {
        [aCoder encodeObject:self.price forKey:OrderPriceKey];
    }
    if (!isEmptyString(self.foodPrice)) {
        [aCoder encodeObject:self.foodPrice forKey:OrderFoodPriceKey];
    }
    if (!isEmptyString(self.imageUrl)) {
        [aCoder encodeObject:self.imageUrl forKey:OrderImageUrlKey];
    }
    [aCoder encodeObject:[NSNumber numberWithInteger:self.count] forKey:OrderCountKey];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isCoupon] forKey:OrderIsCouponKey];
    [aCoder encodeObject:self.couponPrice forKey:OrderCouponPriceKey];
    [aCoder encodeObject:[NSNumber numberWithInteger:self.couponCount] forKey:OrderCouponCountKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.foodId = [aDecoder decodeObjectForKey:ObjectIdKey];
        self.name = [aDecoder decodeObjectForKey:OrderNameKey];
        self.imageUrl = [aDecoder decodeObjectForKey:OrderImageUrlKey];
        self.price = [aDecoder decodeObjectForKey:OrderPriceKey];
        self.foodPrice = [aDecoder decodeObjectForKey:OrderFoodPriceKey];
        self.count = [[aDecoder decodeObjectForKey:OrderCountKey] integerValue];
        self.isCoupon = [[aDecoder decodeObjectForKey:OrderIsCouponKey] boolValue];
        self.couponPrice = [aDecoder decodeObjectForKey:OrderCouponPriceKey];
        self.couponCount = [[aDecoder decodeObjectForKey:OrderCouponCountKey] integerValue];
    }
    return self;
}

@end
