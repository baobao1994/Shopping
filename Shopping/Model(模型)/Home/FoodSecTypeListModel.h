//
//  FoodSecTypeListModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/9.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodSecTypeListModel : NSObject

@property (nonatomic, copy) NSString *foodType;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
