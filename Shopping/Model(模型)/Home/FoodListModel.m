//
//  FoodListModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/5.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodListModel.h"
#import "ConstString.h"

@implementation FoodListModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.imageUrl = [dic objectForKey:FoodListImageUrlKey];
        self.name = [dic objectForKey:FoodListNameKey];
        self.type = [[dic objectForKey:FoodListTypeKey] integerValue];
    }
    return self;
}

@end
