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
#import "OrderModel.h"
#import "QQButton.h"
#import "Toast.h"

NSString *const FoodDetailCollectionViewCellIdentifier = @"FoodDetailCollectionViewCell";

@interface FoodDetailShowView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellCountLabel;
@property (weak, nonatomic) IBOutlet UITextView *introduceTV;
@property (weak, nonatomic) IBOutlet QQButton *orderCountButton;
@property (nonatomic, strong) NSMutableArray *orderList;

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
        self.orderList = OrderManagerInstance.orderList;
        [self.orderCountButton setDestroyAnimationsBlock:^{
            FoodCollecModel *foodCollecModel = self.dateSource[self.currentIndex];
            for (OrderModel *orderModel in self.orderList) {
                if ([foodCollecModel.foodId isEqualToString:orderModel.foodId]) {
                    [OrderManagerInstance removeFoodCollecOrder:foodCollecModel];
                    self.orderList = OrderManagerInstance.orderList;
                    [self.orderCountButton setTitle:@"0" forState:UIControlStateNormal];
                    break;
                }
            }
        }];
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
    self.currentIndex = scrollView.contentOffset.x / (UIScreenWidth - 120);
    [self reloadShowDate];
}

- (void)reload {
    [self reloadShowDate];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    if (self.currentIndex != 0) {
        [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentOffset.x + 30, 0) animated:NO];
    }
}

- (IBAction)didSelectAddShoppingCartBtn:(UIButton *)sender {
    [OrderManagerInstance addFoodCollecOrder:self.dateSource[self.currentIndex]];
    [self reloadShowDate];
}

- (IBAction)didSelectBuyBtn:(UIButton *)sender {
    FoodCollecModel *foodCollecModel = self.dateSource[self.currentIndex];
    NSString *orderCount = @"0";
    for (OrderModel *orderModel in self.orderList) {
        if ([foodCollecModel.foodId isEqualToString:orderModel.foodId]) {
            orderCount = [NSString stringWithFormat:@"%ld",orderModel.count];
            break;
        }
    }
    if ([orderCount isEqualToString:@"0"]) {
        [OrderManagerInstance addFoodCollecOrder:foodCollecModel];
    }
    self.toGoBuy();
}

- (void)reloadShowDate {
    FoodCollecModel *foodCollecModel = self.dateSource[self.currentIndex];
    self.foodNameLabel.text = foodCollecModel.name;
    self.priceLabel.text = [NSString stringWithFormat:@"价格:%@元",foodCollecModel.price];
    self.sellCountLabel.text = [NSString stringWithFormat:@"销售数量:%@",foodCollecModel.sellCount];
    NSString *orderCount = @"0";
    for (OrderModel *orderModel in self.orderList) {
        if ([foodCollecModel.foodId isEqualToString:orderModel.foodId]) {
            orderCount = [NSString stringWithFormat:@"%ld",orderModel.count];
            break;
        }
    }
    self.orderCountButton.transform = CGAffineTransformIdentity;
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
            self.orderCountButton.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
            self.orderCountButton.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
            self.orderCountButton.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    } completion:^(BOOL finished) {
        [self.orderCountButton setTitle:orderCount forState:UIControlStateNormal];
    }];
}

@end
