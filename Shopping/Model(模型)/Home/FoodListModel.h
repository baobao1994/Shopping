//
//  FoodListModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/5.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodListModel : NSObject

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) NSInteger showType;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
