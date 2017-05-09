//
//  FoodSecTypeListModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/9.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodSecTypeListModel.h"
#import "ConstString.h"

@implementation FoodSecTypeListModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic objectForKey:FoodSecTypeListNameKey];
        self.type = [dic objectForKey:FoodSecTypeListTypeKey];
        self.foodType = [dic objectForKey:FoodSecTypeListFoodTypeKey];
    }
    return self;
}

@end
