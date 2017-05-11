//
//  ShoopingCartTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "ShoopingCartTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "OrderModel.h"

@interface ShoopingCartTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *foodPriceLabel;

@end

@implementation ShoopingCartTableViewCell

- (void)setContent:(OrderModel *)orderModel {
    self.nameLabel.text = orderModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"单价 %@元",orderModel.price];
    if (orderModel.isCoupon) {
        float couponPrice = 0;
        if (orderModel.count >= orderModel.couponCount) {
            couponPrice += [orderModel.couponPrice floatValue] * orderModel.couponCount;
        } else {
            couponPrice = [orderModel.couponPrice floatValue];
        }
        self.couponPriceLabel.text = [NSString stringWithFormat:@"该单品优惠%.2f元",couponPrice];
    } else {
        self.couponPriceLabel.text = @"该单品无优惠";
    }
    self.foodPriceLabel.text = [NSString stringWithFormat:@"一共%@元",orderModel.foodPrice];
    self.foodCountTF.text = [NSString stringWithFormat:@"%ld",orderModel.count];
}

@end
