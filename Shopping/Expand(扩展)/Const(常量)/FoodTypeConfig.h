//
//  FoodTypeConfig.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/5.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>
//这些都是ID，后面再改
typedef NS_ENUM(NSInteger, FoodType) {
    FoodTypeOfFruitJuice    = 100000,       //果汁
    FoodTypeOfMilkTea       = 200000,       //奶茶
    FoodTypeOfCoffee        = 300000,       //咖啡
    FoodTypeOfCocktail      = 400000,       //鸡尾酒
    FoodTypeOfFruitSalad    = 500000,       //水果沙拉
    FoodTypeOfSweetmeats    = 600000,       //甜品
    FoodTypeOfBBQ           = 700000,       //烧烤
};

typedef NS_ENUM(NSInteger, FoodSecondType) {
    FoodSecondTypeOfMR      = 110100,       //美容
    FoodSecondTypeOfTS      = 110200,       //提神
    FoodSecondTypeOfHF      = 110300,       //护肤
    FoodSecondTypeOfZQDKL   = 110400,       //增强抵抗力
    FoodSecondTypeOfYW      = 110500,       //养胃
    FoodSecondTypeOfQSGZ    = 110600,       //汽水果汁
    FoodSecondTypeOfZZNC    = 210100,       //珍珠奶茶
    FoodSecondTypeOfGSNC    = 210200,       //港式奶茶
    FoodSecondTypeOfYSNC    = 210300,       //英式奶茶
    FoodSecondTypeOfKFNT    = 310100,       //咖啡拿铁类/无分类
    FoodSecondTypeOfJWJ     = 410100,       //鸡尾酒/无分类
    FoodSecondTypeOfSGSL    = 510100,       //水果沙拉/无分类
    FoodSecondTypeOfTP      = 610100,       //甜品/无分类
    FoodSecondTypeOfLDNZP   = 710100,       //陆地肉制品
    FoodSecondTypeOfSCZP    = 710200,       //蔬菜制品
    FoodSecondTypeOfHXRZP   = 710300,       //海鲜肉制品
};

@interface FoodTypeConfig : NSObject

@end
