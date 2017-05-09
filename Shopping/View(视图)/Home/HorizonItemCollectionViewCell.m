//
//  HorizonItemCollectionViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HorizonItemCollectionViewCell.h"
#import "FoodCollecModel.h"
#import "UIView+Addtion.h"

@interface HorizonItemCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellCountLabel;

@end

@implementation HorizonItemCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCornerRadius:5.0f];
}

- (void)setConent:(FoodCollecModel *)foodCollecModel {
    self.priceLabel.text = [NSString stringWithFormat:@"价格:%@元",foodCollecModel.price];
    self.sellCountLabel.text = [NSString stringWithFormat:@"销售次数:%@次",foodCollecModel.sellCount];
}

@end
