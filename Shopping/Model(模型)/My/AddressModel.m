//
//  AddressModel.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "AddressModel.h"
#import "ConstString.h"

@implementation AddressModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.name = [dic objectForKey:UserNameKey];
        self.sex = [dic objectForKey:UserSexKey];
        self.telephone = [dic objectForKey:UserTelePhoneKey];
        self.address = [dic objectForKey:UserAddressKey];
        self.detailAddress = [dic objectForKey:UserDetailAddressKey];
        self.latitude = [dic objectForKey:AddressLatitudeKey];
        self.longitude = [dic objectForKey:AddressLongitudeKey];
    }
    return self;
}

@end
