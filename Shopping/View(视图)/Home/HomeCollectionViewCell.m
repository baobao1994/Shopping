//
//  HomeCollectionViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "FoodListModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+Addtion.h"

@interface HomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCornerRadius:5];
}

- (void)setConent:(FoodListModel *)foodListModel {
    [self.foodImageView sd_setImageWithURL:[NSURL URLWithString:foodListModel.imageUrl]];
    self.nameLabel.text = foodListModel.name;
}

@end
