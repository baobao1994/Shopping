//
//  FoodCollecModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartOrderModel;

@interface FoodCollecModel : NSObject

@property (nonatomic, copy) NSString *foodId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *sellCount;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *foodType;
@property (nonatomic, copy) NSString *foodSecType;
@property (nonatomic, assign) BOOL isCoupon;
@property (nonatomic, copy) NSString *couponPrice;
@property (nonatomic, assign) NSInteger couponCount;

- (id)initWithDictionary:(NSDictionary *)dic;
- (id)initWithCartOrderModel:(CartOrderModel *)CartOrderModel;

@end
