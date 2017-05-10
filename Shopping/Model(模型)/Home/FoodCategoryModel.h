//
//  FoodCategoryModel.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FoodCategoryModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *foodType;
@property (nonatomic, copy) NSString *foodSecType;
@property (nonatomic, strong) NSMutableArray *foodCategorylist;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL animate;

- (id)initWithDictionary:(NSDictionary *)dic;

@end
