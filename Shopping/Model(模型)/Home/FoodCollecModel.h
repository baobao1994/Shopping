//
//  FoodCollecModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCollecModel : NSObject

@property (nonatomic, copy) NSString *foodCategoryId;
@property (nonatomic, copy) NSString *foodCollecId;
@property (nonatomic, copy) NSString *foodCollecName;
@property (nonatomic, copy) NSString *foodCollecImageName;
@property (nonatomic, copy) NSString *foodCollecPrice;
@property (nonatomic, assign) NSInteger foodCollecSellCount;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
