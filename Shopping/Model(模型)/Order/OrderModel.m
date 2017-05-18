//
//  OrderModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/17.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderModel.h"
#import "ConstString.h"
#import "CartOrderModel.h"

@implementation OrderModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.objectId = [dic objectForKey:ObjectIdKey];
        self.is_evaluate = [[dic objectForKey:OrderIsEvaluateKey] boolValue];
        self.status = [dic objectForKey:OrderStatusKey];
        self.userId = [dic objectForKey:UserObjectIdKey];
        self.price = [dic objectForKey:OrderPriceKey];
        NSArray *orderList = [dic objectForKey:OrderListKey];
        self.orderList = [NSMutableArray arrayWithCapacity:orderList.count];
        for (NSDictionary *cartOrderDic in orderList) {
            CartOrderModel *cartOrderInfo = [[CartOrderModel alloc] initWithDictionary:cartOrderDic];
            [self.orderList addObject:cartOrderInfo];
        }
    }
    return self;
}

@end
