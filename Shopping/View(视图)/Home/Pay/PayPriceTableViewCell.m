//
//  PayPriceTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PayPriceTableViewCell.h"
#import "CartOrderModel.h"

@interface PayPriceTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@end

@implementation PayPriceTableViewCell

- (void)setContent:(NSMutableArray *)orderList {
    self.priceLabel.text = [NSString stringWithFormat:@"一共%.2f元,已优惠%.2f元",[OrderManagerInstance calculatePrice:orderList],[OrderManagerInstance calculateCouponPrice:orderList]];
    self.allPriceLabel.text = [NSString stringWithFormat:@"一共%.2f元",[OrderManagerInstance calculatePrice:orderList]];
}

@end
