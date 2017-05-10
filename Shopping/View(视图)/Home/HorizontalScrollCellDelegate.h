//
//  HorizontalScrollCellDelegate.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HorizontalScrollCellDelegate <NSObject>

@optional

/**
 Set the number of items in each horizontally scrolled row.
 
 @param horizontalCellContentsView The Collection View of all Content Cells in each horizontally scrolled row.
 @param tableViewIndexPath The index path of HorizontalCell object related to its position in the tableView.
 
 @return Returns the number of item in the specified tableViewIndexPath.
 
 */
- (NSInteger)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView numberOfItemsInTableViewIndexPath:(NSIndexPath *)tableViewIndexPath;

/**
 Configure each item in the content-cell.
 
 @param horizontalCellContentsView The Collection View of all Content Cells in each horizontally scrolled row.
 @param contentIndexPath The index path of content-cell object related to its position in the horizontalCellContentsView.
 @param tableViewIndexPath The index path of HorizontalCell object related to its position in the tableView.
 
 @return Content-cell object
 */
- (UICollectionViewCell *)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView cellForItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath;


- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 Manage the item selection.
 
 @param horizontalCellContentsView The Collection View of all Content Cells in each horizontally scrolled row.
 @param contentIndexPath The index path of content-cell object related to its position in the horizontalCellContentsView.
 @param tableViewIndexPath The index path of HorizontalCell object related to its position in the tableView.
 */
- (void)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView didSelectItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath;


- (CGFloat)tableViewHeightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)contentOffset:(CGPoint)contentOffset atIndex:(NSInteger)atIndex;

@end
