//
//  HomeViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HomeViewController.h"
#import "PullToRefreshCollectionView.h"
#import "HomeHeaderCollectionReusableView.h"
#import "HomeCollectionViewCell.h"
#import "HomeFooterCollectionReusableView.h"

#import "FoodListViewController.h"

NSString *const HomeCollectionViewCellIdentifier = @"HomeCollectionViewCell";
NSString *const HomeHeaderCollectionReusableViewIdentifier = @"HomeHeaderCollectionReusableView";
NSString *const HomeFooterCollectionReusableViewIdentifier = @"HomeFooterCollectionReusableView";

@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HomeCollectionViewCellIdentifier];
    [self.collectionView registerClass:[HomeHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeHeaderCollectionReusableViewIdentifier];
    [self.collectionView registerClass:[HomeFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HomeFooterCollectionReusableViewIdentifier];
    UICollectionViewFlowLayout *lotteryLayout = [[UICollectionViewFlowLayout alloc] init];
    lotteryLayout.itemSize = CGSizeMake((UIScreenWidth - 90) / 2, (UIScreenWidth - 90) / 2 * 1.1);
    lotteryLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    self.collectionView.collectionViewLayout = lotteryLayout;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodListViewController *foodListVC = [[FoodListViewController alloc] init];
    [self.navigationController pushViewController:foodListVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(UIScreenWidth, 120);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(UIScreenWidth, 50);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HomeHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeHeaderCollectionReusableViewIdentifier forIndexPath:indexPath];
        reusableView = header;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        HomeFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HomeFooterCollectionReusableViewIdentifier forIndexPath:indexPath];
        reusableView = footer;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

@end
