//
//  HomeCollectionViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodListModel;

@interface HomeCollectionViewCell : UICollectionViewCell

- (void)setConent:(FoodListModel *)foodListModel;

@end
