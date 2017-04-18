//
//  UserInfoModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userImageName;
@property (nonatomic, copy) NSString *userTelePhone;
@property (nonatomic, copy) NSNumber *userBalance;
@property (nonatomic, copy) NSNumber *userCoupon;
@property (nonatomic, copy) NSNumber *userIntegral;
@property (nonatomic, copy) NSString *userPassword;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
