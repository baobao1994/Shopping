//
//  FoodDetailShowView.h
//  Shopping
//
//  Created by baobao on 2017/4/29.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FoodCollecModel;

@interface FoodDetailShowView : UIView

@property (nonatomic, copy) void (^toGoBuy)(void);
@property (nonatomic, copy) void (^toGoAddOrder)(FoodCollecModel *foodCollecModel);
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSMutableArray *dateSource;

- (void)reload;

@end
