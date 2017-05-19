//
//  OrderModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/17.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AddressModel;

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) BOOL isEvaluate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) NSMutableArray *orderList;
@property (nonatomic, strong) AddressModel *address;
@property (nonatomic, assign) BOOL isInTheShop;
@property (nonatomic, copy) NSString *sendPrice;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
