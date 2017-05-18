//
//  OrderManager.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderManager.h"
#import "FoodCollecModel.h"
#import "CartOrderModel.h"
#import "ConstString.h"

@implementation OrderManager

- (id)init {
    if (self = [super init]) {
        NSDictionary *cacheDic = [self getCacheDicFromFile];
        self.orderList = [cacheDic objectForKey:OrderInfoCache];
        if (self.orderList.count == 0) {
            self.orderList = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

+ (OrderManager *)shareInstance {
    static OrderManager *_info;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _info = [[OrderManager alloc] init];
    });
    return _info;
}

- (void)saveOrderList:(NSMutableArray *)orderList {
    self.orderList = orderList;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:OrderInfoCacheFile];
    NSMutableDictionary *cacheDic = [NSMutableDictionary dictionaryWithCapacity:1];
    if (orderList != nil) {
        [cacheDic setObject:orderList forKey:OrderInfoCache];
    }
    [NSKeyedArchiver archiveRootObject:cacheDic toFile:cachePath];
}

- (void)deleteOrderList {
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:OrderInfoCacheFile];
    DELETE_FILE(cachePath);
    [self.orderList removeAllObjects];
}

- (void)addFoodCollecOrder:(FoodCollecModel *)foodCollecModel {
    BOOL isNotExist = YES;
    NSString *foodId = foodCollecModel.foodId;
    for (CartOrderModel *CartOrderModel in self.orderList) {
        NSString *CartOrderModelId = CartOrderModel.foodId;
        if ([CartOrderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [CartOrderModel.foodPrice floatValue];
            if (isCoupon && CartOrderModel.count < CartOrderModel.couponCount) {
                foodPrice += [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice += [foodCollecModel.price floatValue];
            }
            CartOrderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            CartOrderModel.count ++;
            isNotExist = NO;
            break;
        }
    }
    if (isNotExist) {
        CartOrderModel *order = [[CartOrderModel alloc] init];
        order.foodId = foodCollecModel.foodId;
        order.name = foodCollecModel.name;
        order.price = foodCollecModel.price;
        order.count = 1;
        order.isCoupon = foodCollecModel.isCoupon;
        if (order.isCoupon) {
            order.foodPrice = [NSString stringWithFormat:@"%.2f",[foodCollecModel.couponPrice floatValue]];
        } else {
            order.foodPrice = [NSString stringWithFormat:@"%.2f",[foodCollecModel.price floatValue]];
        }
        order.couponPrice = foodCollecModel.couponPrice;
        order.couponCount = foodCollecModel.couponCount;
        order.imageUrl = foodCollecModel.imageUrl;
        [self.orderList addObject:order];
    }
    [OrderManagerInstance saveOrderList:self.orderList];
}

- (void)cutFoodCollecOrder:(FoodCollecModel *)foodCollecModel {
    NSInteger orderCount = -1;
    NSInteger atIndex = 0;
    NSString *foodId = foodCollecModel.foodId;
    for (CartOrderModel *CartOrderModel in self.orderList) {
        NSString *CartOrderModelId = CartOrderModel.foodId;
        if ([CartOrderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [CartOrderModel.foodPrice floatValue];
            if (isCoupon && CartOrderModel.count <= CartOrderModel.couponCount) {
                foodPrice -= [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice -= [foodCollecModel.price floatValue];
            }
            CartOrderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            CartOrderModel.count --;
            orderCount = CartOrderModel.count;
            break;
        }
        atIndex ++;
    }
    if (orderCount == 0) {
        [self.orderList removeObjectAtIndex:atIndex];
    }
    [OrderManagerInstance saveOrderList:self.orderList];
}

- (void)removeFoodCollecOrder:(FoodCollecModel *)foodCollecModel {
    NSString *foodId = foodCollecModel.foodId;
    for (int i = 0; i < self.orderList.count; i ++) {
        CartOrderModel *CartOrderModel = self.orderList[i];
        NSString *CartOrderModelId = CartOrderModel.foodId;
        if ([CartOrderModelId isEqualToString:foodId]) {
            [self.orderList removeObjectAtIndex:i];
            break;
        }
    }
    [OrderManagerInstance saveOrderList:self.orderList];
}

- (void)changeFoodCollecOrder:(FoodCollecModel *)foodCollecModel Count:(NSInteger)count {
    NSString *foodId = foodCollecModel.foodId;
    for (CartOrderModel *CartOrderModel in self.orderList) {
        NSString *CartOrderModelId = CartOrderModel.foodId;
        if ([CartOrderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            CartOrderModel.count = count;
            float foodPrice = 0.0;
            if (isCoupon) {
                if (count > CartOrderModel.couponCount) {
                    foodPrice += [foodCollecModel.couponPrice floatValue] * foodCollecModel.couponCount;
                    count -= foodCollecModel.couponCount;
                } else {
                    foodPrice += [foodCollecModel.couponPrice floatValue] * count;
                    count = 0;
                }
            }
            if (count) {
                foodPrice += [foodCollecModel.price floatValue] * count;
            }
            CartOrderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            break;
        }
    }
    [OrderManagerInstance saveOrderList:self.orderList];
}

- (float)calculatePrice:(NSMutableArray *)orderList {
    float price = 0.00;
    float couponPrice = 0;
    for (CartOrderModel *CartOrderModel in orderList) {
        price += [CartOrderModel.foodPrice floatValue];
        if (CartOrderModel.count >= CartOrderModel.couponCount) {
            couponPrice += [CartOrderModel.couponPrice floatValue] * CartOrderModel.couponCount;
        } else {
            couponPrice = [CartOrderModel.couponPrice floatValue];
        }
    }
    return price;
}

- (float)calculateCouponPrice:(NSMutableArray *)orderList {
    float price = 0.00;
    float couponPrice = 0;
    for (CartOrderModel *CartOrderModel in orderList) {
        price += [CartOrderModel.foodPrice floatValue];
        if (CartOrderModel.count >= CartOrderModel.couponCount) {
            couponPrice += [CartOrderModel.couponPrice floatValue] * CartOrderModel.couponCount;
        } else {
            couponPrice = [CartOrderModel.couponPrice floatValue];
        }
    }
    return couponPrice;
}

#pragma mark - Private Method

- (NSDictionary *)getCacheDicFromFile {
    NSDictionary *cacheDic = nil;
    NSString *cachePath = [DOCUMENT_PATH stringByAppendingPathComponent:OrderInfoCacheFile];
    NSMutableData *cacheData = [[NSMutableData alloc] initWithContentsOfFile:cachePath];
    if (cacheData != nil) {
        cacheDic = [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    }
    return cacheDic;
}

@end
