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
        self.foodCategoryId = [dic objectForKey:FoodCategoryIdKey];
        self.foodCategoryName = [dic objectForKey:FoodCategoryNameKey];
        self.foodCategoryImageName = [dic objectForKey:FoodCategoryImageNameKey];
        NSArray *foodCategoryList = [dic objectForKey:FoodCategoryListKey];
        self.foodCategorylist = [NSMutableArray arrayWithCapacity:foodCategoryList.count];
        for (NSDictionary *foodCollec in foodCategoryList) {
            FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithDictionary:foodCollec];
            [self.foodCategorylist addObject:foodCollecModel];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.foodCategoryId)) {
        [aCoder encodeObject:self.foodCategoryId forKey:FoodCategoryIdKey];
    }
    if (!isEmptyString(self.foodCategoryName)) {
        [aCoder encodeObject:self.foodCategoryName forKey:FoodCategoryNameKey];
    }
    if (!isEmptyString(self.foodCategoryImageName)) {
        [aCoder encodeObject:self.foodCategoryImageName forKey:FoodCategoryImageNameKey];
    }
    if (self.foodCategorylist.count) {
        [aCoder encodeObject:self.foodCategorylist forKey:FoodCategoryListKey];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.foodCategoryId = [aDecoder decodeObjectForKey:FoodCategoryIdKey];
        self.foodCategoryName = [aDecoder decodeObjectForKey:FoodCategoryNameKey];
        self.foodCategoryImageName = [aDecoder decodeObjectForKey:FoodCategoryImageNameKey];
        self.foodCategorylist = [aDecoder decodeObjectForKey:FoodCategoryListKey];
    }
    return self;
}

@end
