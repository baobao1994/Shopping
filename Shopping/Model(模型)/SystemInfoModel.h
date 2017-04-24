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
@property (nonatomic, assign) BOOL isOpen;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
