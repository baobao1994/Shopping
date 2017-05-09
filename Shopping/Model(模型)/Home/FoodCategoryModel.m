//
//  FoodCategoryModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodCategoryModel.h"
#import "FoodCollecModel.h"
#import "ConstString.h"

@implementation FoodCategoryModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic objectForKey:FoodCategoryNameKey];
        self.imageUrl = [dic objectForKey:FoodCategoryImageUrlKey];
        self.foodType = [dic objectForKey:FoodCategoryFoodTypeKey];
        self.foodSecType = [dic objectForKey:FoodCategoryFoodSecTypeKey];
        NSArray *foodCategoryList = [dic objectForKey:FoodCategoryListKey];
        self.foodCategorylist = [NSMutableArray arrayWithCapacity:foodCategoryList.count];
        for (NSDictionary *foodCollec in foodCategoryList) {
            FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithDictionary:foodCollec];
            [self.foodCategorylist addObject:foodCollecModel];
        }
    }
    return self;
}

@end
