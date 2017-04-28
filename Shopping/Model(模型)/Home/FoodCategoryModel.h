//
//  FoodCategoryModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategoryModel : NSObject

@property (nonatomic, copy) NSString *foodCategoryId;
@property (nonatomic, copy) NSString *foodCategoryName;
@property (nonatomic, copy) NSString *foodCategoryImageName;
@property (nonatomic, strong) NSMutableArray *foodCategorylist;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
