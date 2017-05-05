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


@interface PullToRefreshCollectionView : UICollectionView <EGORefreshTableHeaderDelegate,EGORefreshTableFooterDelegate>{
    EGORefreshTableFooterView *_refreshFooterView;  //加载更多
//    id<PullToRefreshCollectionViewDelegate> _customTableDelegate;
    RefreshCategory _refreshCategory;
    CGPoint _point;//判断是上拉还是下拉
    
    BOOL _reloading;
    BOOL _isLoadedAllTheData;//是否已经加载完服务器端所有的数据
}

@property (nonatomic, assign) BOOL isLoadedAllTheData;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, assign) id<PullToRefreshCollectionViewDelegate> customTableDelegate;

- (void)reloadTableViewHeaderDataSource;
- (void)reloadTableViewFooterDataSource;
- (void)doneLoadingTableViewData;
- (void)setRefreshCategory:(RefreshCategory)refreshCategory;

- (void)customTableViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)customTableViewDidScroll:(UIScrollView *)scrollView;
- (void)customTableViewDidEndDragging:(UIScrollView *)scrollView;
- (void)showNoDataViewWithImage:(UIImage *)image tips:(NSString *)tips;
- (void)hideNoDataView;
- (void)showLoadedAllDataViewWithTips:(NSString *)tips;
- (void)hideLoadedAllDataView;
- (void)addNotification;

@end

