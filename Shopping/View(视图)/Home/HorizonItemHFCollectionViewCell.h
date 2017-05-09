//
//  HorizonItemHFCollectionViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/9.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodSecTypeListModel;

@interface HorizonItemHFCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

- (void)setConent:(FoodSecTypeListModel *)foodSecTypeListModel;

@end
