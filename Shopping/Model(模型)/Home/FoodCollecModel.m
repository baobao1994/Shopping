//
//  FoodCollecModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodCollecModel.h"
#import "ConstString.h"

@implementation FoodCollecModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.foodCategoryId = [dic objectForKey:FoodcategoryIdKey];
        self.foodCollecId = [dic objectForKey:FoodCollecIdKey];
        self.foodCollecName = [dic objectForKey:FoodCollecNameKey];
        self.foodCollecImageName = [dic objectForKey:FoodCollecImageNameKey];
        self.foodCollecPrice = [dic objectForKey:FoodCollecPriceKey];
        self.foodCollecSellCount = [[dic objectForKey:FoodCollecSellCountKey] integerValue];
    }
    return self;
}

@end
