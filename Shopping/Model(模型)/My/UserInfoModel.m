//
//  UserInfoModel.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "UserInfoModel.h"
#import "ConstString.h"

@implementation UserInfoModel

- (id)initWithDictionary:(NSDictionary *)dic {
    if (self = [super init]) {
        self.userName = [dic objectForKey:UserNameKey];
        self.userImageName = [dic objectForKey:UserImageNameKey];
        self.userTelePhone = [dic objectForKey:UserTelePhoneKey];
        self.userBalance = [dic objectForKey:UserBalanceKey];
        self.userCoupon = [dic objectForKey:UserCouponKey];
        self.userIntegral = [dic objectForKey:UserIntegralKey];
        self.userPassword = [dic objectForKey:UserPasswordKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    if (!isEmptyString(self.userName)) {
        [aCoder encodeObject:self.userName forKey:UserNameKey];
    }
    if (!isEmptyString(self.userImageName)) {
        [aCoder encodeObject:self.userImageName forKey:UserImageNameKey];
    }
    if (!isEmptyString(self.userTelePhone)) {
        [aCoder encodeObject:self.userTelePhone forKey:UserTelePhoneKey];
    }
    [aCoder encodeObject:self.userBalance forKey:UserBalanceKey];
    [aCoder encodeObject:self.userCoupon forKey:UserCouponKey];
    [aCoder encodeObject:self.userIntegral forKey:UserIntegralKey];
    if (!isEmptyString(self.userPassword)) {
        [aCoder encodeObject:self.userPassword forKey:UserPasswordKey];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:UserNameKey];
        self.userImageName = [aDecoder decodeObjectForKey:UserImageNameKey];
        self.userTelePhone = [aDecoder decodeObjectForKey:UserTelePhoneKey];
        self.userBalance = [aDecoder decodeObjectForKey:UserBalanceKey];
        self.userCoupon = [aDecoder decodeObjectForKey:UserCouponKey];
        self.userIntegral = [aDecoder decodeObjectForKey:UserIntegralKey];
        self.userPassword = [aDecoder decodeObjectForKey:UserPasswordKey];
    }
    return self;
}

@end
