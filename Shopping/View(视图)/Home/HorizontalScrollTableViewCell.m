//
//  HorizontalScrollTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "HorizontalScrollTableViewCell.h"

@interface HorizontalScrollTableViewCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation HorizontalScrollTableViewCell

- (void)reloadData {
    [_collectionView setContentOffset:self.contentOffset animated:self.animate];
    [_collectionView reloadData];
}

#pragma mark - UICollectionView data source

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.delegate horizontalCellContentsView:collectionView numberOfItemsInTableViewIndexPath:self.tableViewIndexPath];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate horizontalCellContentsView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate horizontalCellContentsView:collectionView cellForItemAtContentIndexPath:indexPath inTableViewIndexPath:self.tableViewIndexPath];
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate horizontalCellContentsView:collectionView didSelectItemAtContentIndexPath:indexPath inTableViewIndexPath:self.tableViewIndexPath];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.delegate contentOffset:scrollView.contentOffset atIndex:self.collectionView.tag];
}

@end
