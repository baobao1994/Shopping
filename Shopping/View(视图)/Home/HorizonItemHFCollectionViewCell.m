//
//  HorizonItemHFCollectionViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/9.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HorizonItemHFCollectionViewCell.h"
#import "FoodSecTypeListModel.h"
#import "UIView+Addtion.h"

@interface HorizonItemHFCollectionViewCell ()

@end

@implementation HorizonItemHFCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setCornerRadius:5.0f];
}

- (void)setConent:(FoodSecTypeListModel *)foodSecTypeListModel {
    self.nameLabel.text = foodSecTypeListModel.name;
}

@end
