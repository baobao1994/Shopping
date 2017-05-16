//
//  OrderManager.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FoodCollecModel;

@interface OrderManager : NSObject

@property (nonatomic, strong) NSMutableArray *orderList;

+ (OrderManager *)shareInstance;
- (void)saveOrderList:(NSMutableArray *)orderList;
- (void)deleteOrderList;

- (void)addFoodCollecOrder:(FoodCollecModel *)foodCollecModel;
- (void)cutFoodCollecOrder:(FoodCollecModel *)foodCollecModel;
- (void)removeFoodCollecOrder:(FoodCollecModel *)foodCollecModel;

- (void)changeFoodCollecOrder:(FoodCollecModel *)foodCollecModel Count:(NSInteger)count;

@end
