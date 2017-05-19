//
//  SystemInfoModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/24.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "SystemInfoModel.h"
#import "ConstString.h"

@implementation SystemInfoModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.serviceTel = [dic objectForKey:SystemServiceTelKey];
        self.openTime = [dic objectForKey:SystemOpenTimeKey];
        self.homeBottomTip = [dic objectForKey:SystemHomeBottomTipKey];
        self.isOpen = [[dic objectForKey:SystemIsOpenKey] boolValue];
        self.latitude = [dic objectForKey:AddressLatitudeKey];
        self.longitude = [dic objectForKey:AddressLongitudeKey];
        self.sendFreeDistance = [dic objectForKey:SystemSendFreeDistanceKey];
        self.limitSendPrice = [dic objectForKey:SystemLimitSendPriceKey];
        self.beginSendPrice = [dic objectForKey:SystemBeginSendPriceKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.serviceTel)) {
        [aCoder encodeObject:self.serviceTel forKey:SystemServiceTelKey];
    }
    if (!isEmptyString(self.openTime)) {
        [aCoder encodeObject:self.openTime forKey:SystemOpenTimeKey];
    }
    if (!isEmptyString(self.homeBottomTip)) {
        [aCoder encodeObject:self.homeBottomTip forKey:SystemHomeBottomTipKey];
    }
    [aCoder encodeObject:[NSNumber numberWithBool:self.isOpen] forKey:SystemIsOpenKey];
    [aCoder encodeObject:self.latitude forKey:AddressLatitudeKey];
    [aCoder encodeObject:self.longitude forKey:AddressLongitudeKey];
    if (!isEmptyString(self.sendFreeDistance)) {
        [aCoder encodeObject:self.sendFreeDistance forKey:SystemSendFreeDistanceKey];
    }
    if (!isEmptyString(self.limitSendPrice)) {
        [aCoder encodeObject:self.limitSendPrice forKey:SystemLimitSendPriceKey];
    }
    if (!isEmptyString(self.beginSendPrice)) {
        [aCoder encodeObject:self.beginSendPrice forKey:SystemBeginSendPriceKey];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.serviceTel = [aDecoder decodeObjectForKey:SystemServiceTelKey];
        self.openTime = [aDecoder decodeObjectForKey:SystemOpenTimeKey];
        self.homeBottomTip = [aDecoder decodeObjectForKey:SystemHomeBottomTipKey];
        self.isOpen = [[aDecoder decodeObjectForKey:SystemIsOpenKey] boolValue];
        self.latitude = [aDecoder decodeObjectForKey:AddressLatitudeKey];
        self.longitude = [aDecoder decodeObjectForKey:AddressLongitudeKey];
        self.sendFreeDistance = [aDecoder decodeObjectForKey:SystemSendFreeDistanceKey];
        self.limitSendPrice = [aDecoder decodeObjectForKey:SystemLimitSendPriceKey];
        self.beginSendPrice = [aDecoder decodeObjectForKey:SystemBeginSendPriceKey];
    }
    return self;
}

@end
