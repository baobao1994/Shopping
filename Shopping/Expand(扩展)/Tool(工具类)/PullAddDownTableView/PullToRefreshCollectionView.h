//
//  PullToRefreshUICollectionView.h
//  TigerLottery
//
//  Created by Legolas on 2017/4/24.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

typedef enum{
    BothRefresh = 0,
    DropdownRefresh,
    PullRefresh,
    NoRefresh
}RefreshCategory;

#import "EGORefreshTableHeaderView.h"
#import "EGORefreshTableFooterView.h"

@protocol PullToRefreshCollectionViewDelegate <NSObject>

@optional
- (void)getHeaderDataSoure;
- (void)getFooterDataSoure;

@end


@interface PullToRefreshCollectionView : UICollectionView

@property (nonatomic, assign) BOOL isLoadedAllTheData;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) id<PullToRefreshCollectionViewDelegate> customTableDelegate;

@end
