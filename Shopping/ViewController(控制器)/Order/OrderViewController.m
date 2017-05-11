//
//  OrderViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderModel.h"
#import "FoodCollecModel.h"

@interface OrderViewController ()

@property (nonatomic, strong) NSMutableArray *orderArr;
@property (nonatomic, strong) FoodCollecModel *foodCollecModel1;
@property (nonatomic, strong) FoodCollecModel *foodCollecModel2;
@property (nonatomic, strong) FoodCollecModel *foodCollecModel3;
@property (nonatomic, strong) FoodCollecModel *foodCollecModel4;
@property (nonatomic, strong) FoodCollecModel *foodCollecModel5;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}
- (IBAction)nslogBtn:(UIButton *)sender {
    float price = 0;
    for (OrderModel *orderModel in self.orderArr) {
        price += [orderModel.foodPrice floatValue];
    }
    NSLog(@"price = %.2f",price);
}

- (void)addOrder:(FoodCollecModel *)foodCollecModel {
    BOOL isNotExist = YES;
    NSString *foodId = foodCollecModel.foodId;
    for (OrderModel *orderModel in self.orderArr) {
        NSString *orderModelId = orderModel.foodId;
        if ([orderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [orderModel.foodPrice floatValue];
            if (isCoupon && orderModel.count < orderModel.couponCount) {
                foodPrice += [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice += [foodCollecModel.price floatValue];
            }
            orderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            orderModel.count ++;
            isNotExist = NO;
            break;
        }
    }
    if (isNotExist) {
        OrderModel *order = [[OrderModel alloc] init];
        order.foodId = foodCollecModel.foodId;
        order.name = foodCollecModel.name;
        order.price = foodCollecModel.price;
        order.count = 1;
        order.isCoupon = foodCollecModel.isCoupon;
        if (order.isCoupon) {
            order.foodPrice = foodCollecModel.couponPrice;
        } else {
            order.foodPrice = foodCollecModel.price;
        }
        order.couponPrice = foodCollecModel.couponPrice;
        order.couponCount = foodCollecModel.couponCount;
        order.imageUrl = foodCollecModel.imageUrl;
        [self.orderArr addObject:order];
    }
}

- (void)cutOrder:(FoodCollecModel *)foodCollecModel {
    NSInteger orderCount = -1;
    NSInteger atIndex = 0;
    NSString *foodId = foodCollecModel.foodId;
    for (OrderModel *orderModel in self.orderArr) {
        NSString *orderModelId = orderModel.foodId;
        if ([orderModelId isEqualToString:foodId]) {
            BOOL isCoupon = foodCollecModel.isCoupon;
            float foodPrice = [orderModel.foodPrice floatValue];
            if (isCoupon && orderModel.count <= orderModel.couponCount) {
                foodPrice -= [foodCollecModel.couponPrice floatValue];
            } else {
                foodPrice -= [foodCollecModel.price floatValue];
            }
            orderModel.foodPrice = [NSString stringWithFormat:@"%.2f",foodPrice];
            orderModel.count --;
            orderCount = orderModel.count;
            break;
        }
        atIndex ++;
    }
    if (orderCount == 0) {
        [self.orderArr removeObjectAtIndex:atIndex];
    }
}

- (IBAction)addOrderBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self addOrder:self.foodCollecModel1];
            break;
        case 2:
            [self addOrder:self.foodCollecModel2];
            break;
        case 3:
            [self addOrder:self.foodCollecModel3];
            break;
        case 4:
            [self addOrder:self.foodCollecModel4];
            break;
        case 5:
            [self addOrder:self.foodCollecModel5];
            break;
        default:
            break;
    }
}

- (IBAction)cutOrderBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
            [self cutOrder:self.foodCollecModel1];
            break;
        case 2:
            [self cutOrder:self.foodCollecModel2];
            break;
        case 3:
            [self cutOrder:self.foodCollecModel3];
            break;
        case 4:
            [self cutOrder:self.foodCollecModel4];
            break;
        case 5:
            [self cutOrder:self.foodCollecModel5];
            break;
        default:
            break;
    }
}

- (void)setUp {
    self.orderArr = [[NSMutableArray alloc] init];
    
    self.foodCollecModel1 = [[FoodCollecModel alloc] init];
    self.foodCollecModel1.foodId = @"1001";
    self.foodCollecModel1.name = @"食物1";
    self.foodCollecModel1.price = @"10";
    self.foodCollecModel1.isCoupon = YES;
    self.foodCollecModel1.couponPrice = @"5";
    self.foodCollecModel1.couponCount = 1;

    self.foodCollecModel2 = [[FoodCollecModel alloc] init];
    self.foodCollecModel2.foodId = @"1002";
    self.foodCollecModel2.name = @"食物2";
    self.foodCollecModel2.price = @"20";
    self.foodCollecModel2.isCoupon = NO;
    self.foodCollecModel2.couponPrice = @"8";
    self.foodCollecModel2.couponCount = 1;
    
    self.foodCollecModel3 = [[FoodCollecModel alloc] init];
    self.foodCollecModel3.foodId = @"1003";
    self.foodCollecModel3.name = @"食物3";
    self.foodCollecModel3.price = @"30";
    self.foodCollecModel3.isCoupon = YES;
    self.foodCollecModel3.couponPrice = @"8";
    self.foodCollecModel3.couponCount = 2;
    
    self.foodCollecModel4 = [[FoodCollecModel alloc] init];
    self.foodCollecModel4.foodId = @"1004";
    self.foodCollecModel4.name = @"食物4";
    self.foodCollecModel4.price = @"40";
    self.foodCollecModel4.isCoupon = YES;
    self.foodCollecModel4.couponPrice = @"10";
    self.foodCollecModel4.couponCount = 1;
    
    self.foodCollecModel5 = [[FoodCollecModel alloc] init];
    self.foodCollecModel5.foodId = @"1005";
    self.foodCollecModel5.name = @"食物5";
    self.foodCollecModel5.price = @"50";
    self.foodCollecModel5.isCoupon = NO;
    self.foodCollecModel5.couponPrice = @"8";
    self.foodCollecModel5.couponCount = 1;
}

@end
