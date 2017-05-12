//
//  OrderManager.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderManager.h"
#import "FoodCollecModel.h"
#import "OrderModel.h"
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
}

- (void)addFoodCollecOrder:(FoodCollecModel *)foodCollecModel {
    BOOL isNotExist = YES;
    NSString *foodId = foodCollecModel.foodId;
    for (OrderModel *orderModel in self.orderList) {
        NSString *orderModelId = orderModel.foodId;
        if ([orderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [orderModel.foodPrice floatValue];
            if (isCoupon && orderModel.count < orderModel.couponCount) {
                foodPrice += [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice += [foodCollecModel.price floatValue];
            }
            orderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            orderModel.count ++;
            isNotExist = NO;
            break;
        }
    }
    if (isNotExist) {
        OrderModel *order = [[OrderModel alloc] init];
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
    for (OrderModel *orderModel in self.orderList) {
        NSString *orderModelId = orderModel.foodId;
        if ([orderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [orderModel.foodPrice floatValue];
            if (isCoupon && orderModel.count <= orderModel.couponCount) {
                foodPrice -= [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice -= [foodCollecModel.price floatValue];
            }
            orderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            orderModel.count --;
            orderCount = orderModel.count;
            break;
        }
        atIndex ++;
    }
    if (orderCount == 0) {
        [self.orderList removeObjectAtIndex:atIndex];
    }
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
