//
//  FoodDetailShowView.h
//  Shopping
//
//  Created by baobao on 2017/4/29.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailShowView : UIView

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *dateSource;

- (void)reload;

@end
