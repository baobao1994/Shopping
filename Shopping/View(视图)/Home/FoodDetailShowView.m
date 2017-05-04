//
//  FoodDetailShowView.m
//  Shopping
//
//  Created by baobao on 2017/4/29.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodDetailShowView.h"
#import "FoodDetailFlowLayout.h"
#import "FoodDetailCollectionViewCell.h"

NSString *const FoodDetailCollectionViewCellIdentifier = @"FoodDetailCollectionViewCell";

@interface FoodDetailShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FoodDetailShowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FoodDetailShowView" owner:self options:nil] firstObject];
        self.frame = frame;
        [self.collectionView registerClass:[FoodDetailCollectionViewCell class] forCellWithReuseIdentifier:FoodDetailCollectionViewCellIdentifier];
        FoodDetailFlowLayout *flowlayout = [[FoodDetailFlowLayout alloc] init];
        self.collectionView.collectionViewLayout = flowlayout;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FoodDetailCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    return cell;
}

@end
