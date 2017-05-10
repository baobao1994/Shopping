//
//  HorizontalScrollTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HorizontalScrollCellDelegate.h"

@interface HorizontalScrollTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,weak) id <HorizontalScrollCellDelegate> delegate;
@property (strong, nonatomic) NSIndexPath *tableViewIndexPath;
@property (nonatomic, assign) CGPoint contentOffset;
@property (nonatomic, assign) BOOL animate;

- (void)reloadData;

@end
