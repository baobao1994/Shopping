//
//  PayPriceTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PayPriceTableViewCell.h"
#import "OrderModel.h"

@interface PayPriceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@end

@implementation PayPriceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContent:(NSMutableArray *)orderList {
    float price = 0.00;
    float couponPrice = 0;
    for (OrderModel *orderModel in orderList) {
        price += [orderModel.foodPrice floatValue];
        if (orderModel.count >= orderModel.couponCount) {
            couponPrice += [orderModel.couponPrice floatValue] * orderModel.couponCount;
        } else {
            couponPrice = [orderModel.couponPrice floatValue];
        }
    }
    self.priceLabel.text = [NSString stringWithFormat:@"一共%.2f元,已优惠%.2f元",price,couponPrice];
    self.allPriceLabel.text = [NSString stringWithFormat:@"一共%.2f元",price];
}

@end
