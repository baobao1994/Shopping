//
//  PayOrderTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PayOrderTableViewCell.h"
#import "CartOrderModel.h"

@interface PayOrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation PayOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContent:(CartOrderModel *)CartOrderModel {
    self.foodNameLabel.text = CartOrderModel.name;
    self.countLabel.text = [NSString stringWithFormat:@"x%ld",CartOrderModel.count];
    if (CartOrderModel.isCoupon) {
        float couponPrice = 0;
        if (CartOrderModel.count >= CartOrderModel.couponCount) {
            couponPrice += [CartOrderModel.couponPrice floatValue] * CartOrderModel.couponCount;
        } else {
            couponPrice = [CartOrderModel.couponPrice floatValue];
        }
        self.couponPriceLabel.text = [NSString stringWithFormat:@"该单品优惠%.2f元",couponPrice];
    } else {
        self.couponPriceLabel.text = @"该单品无优惠";
    }
    self.priceLabel.text = [NSString stringWithFormat:@"一共%@元",CartOrderModel.foodPrice];
}

@end
