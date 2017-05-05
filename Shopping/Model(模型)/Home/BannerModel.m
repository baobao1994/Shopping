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

@end
