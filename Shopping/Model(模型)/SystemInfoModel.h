//
//  SystemInfoModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/24.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemInfoModel : NSObject

@property (nonatomic, copy) NSString *serviceTel;
@property (nonatomic, copy) NSString *openTime;
@property (nonatomic, copy) NSString *homeBottomTip;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, copy) NSString *sendFreeDistance;
@property (nonatomic, copy) NSString *limitSendPrice;
@property (nonatomic, copy) NSString *beginSendPrice;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
