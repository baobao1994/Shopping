//
//  BannerModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/5.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "BannerModel.h"
#import "ConstString.h"

@implementation BannerModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.imageUrl = [dic objectForKey:BannerImageUrlKey];
        self.name = [dic objectForKey:BannerNameKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.imageUrl)) {
        [aCoder encodeObject:self.imageUrl forKey:BannerImageUrlKey];
    }
    if (!isEmptyString(self.name)) {
        [aCoder encodeObject:self.name forKey:BannerNameKey];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.imageUrl = [aDecoder decodeObjectForKey:BannerImageUrlKey];
        self.name = [aDecoder decodeObjectForKey:BannerNameKey];
    }
    return self;
}


@end
