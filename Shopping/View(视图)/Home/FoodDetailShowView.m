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
#import "FoodCollecModel.h"

NSString *const FoodDetailCollectionViewCellIdentifier = @"FoodDetailCollectionViewCell";

@interface FoodDetailShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;

@end

@implementation FoodDetailShowView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"FoodDetailShowView" owner:self options:nil] firstObject];
        self.frame = frame;
        self.dateSource = [[NSMutableArray alloc] init];
        [_collectionView registerNib:[UINib nibWithNibName:@"FoodDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:FoodDetailCollectionViewCellIdentifier];
        FoodDetailFlowLayout *flowlayout = [[FoodDetailFlowLayout alloc] init];
        self.collectionView.collectionViewLayout = flowlayout;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dateSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return  1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FoodDetailCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger current = scrollView.contentOffset.x / (UIScreenWidth - 120);
    FoodCollecModel *foodCollecModel = self.dateSource[current];
    self.foodNameLabel.text = foodCollecModel.name;
}

- (void)reload {
    FoodCollecModel *foodCollecModel = self.dateSource[self.currentIndex];
    self.foodNameLabel.text = foodCollecModel.name;
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    if (self.currentIndex != 0) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + 30, 0) animated:NO];
    }
}

@end
