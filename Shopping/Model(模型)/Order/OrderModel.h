//
//  OrderModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

@property (nonatomic, copy) NSString *objectId;
@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *foodPrice;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL isCoupon;
@property (nonatomic, copy) NSString *couponPrice;
@property (nonatomic, assign) NSInteger couponCount;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
