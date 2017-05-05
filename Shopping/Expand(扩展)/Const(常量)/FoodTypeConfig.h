//
//  FoodTypeConfig.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/5.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FoodType) {
    FoodTypeOfFruitJuice = 10000,       //果汁
    FoodTypeOfMilkTea = 20000,          //奶茶
    FoodTypeOfCoffee = 30000,           //咖啡
    FoodTypeOfCocktail = 40000,         //鸡尾酒
    FoodTypeOfFruitSalad = 50000,       //水果沙拉
    FoodTypeOfSweetmeats = 60000,       //甜品
    FoodTypeOfBBQ = 70000,              //烧烤
};

@interface FoodTypeConfig : NSObject

@end
