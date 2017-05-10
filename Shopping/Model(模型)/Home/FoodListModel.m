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
        self.type = [dic objectForKey:FoodListTypeKey];
        self.showType = [[dic objectForKey:FoodListShowTypeKey] integerValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.imageUrl)) {
        [aCoder encodeObject:self.imageUrl forKey:FoodListImageUrlKey];
    }
    if (!isEmptyString(self.name)) {
        [aCoder encodeObject:self.name forKey:FoodListNameKey];
    }
    if (!isEmptyString(self.type)) {
        [aCoder encodeObject:self.type forKey:FoodListTypeKey];
    }
    [aCoder encodeObject:[NSNumber numberWithInteger:self.showType] forKey:FoodListShowTypeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.imageUrl = [aDecoder decodeObjectForKey:FoodListImageUrlKey];
        self.name = [aDecoder decodeObjectForKey:FoodListNameKey];
        self.type = [aDecoder decodeObjectForKey:FoodListTypeKey];
        self.showType = [[aDecoder decodeObjectForKey:FoodListShowTypeKey] integerValue];
    }
    return self;
}

@end
