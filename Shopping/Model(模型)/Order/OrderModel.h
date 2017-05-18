//
//  OrderModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/17.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, assign) BOOL is_evaluate;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, strong) NSMutableArray *orderList;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
