//
//  PullToRefreshUICollectionView.m
//  TigerLottery
//
//  Created by Legolas on 2017/4/24.
//  Copyright © 2017年 adcocoa. All rights reserved.
//

#import "PullToRefreshCollectionView.h"
#import "ConstString.h"

@interface PullToRefreshCollectionView()

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;
@property (nonatomic, strong) EGORefreshTableFooterView *refreshFooterView;
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UIView *loadedAllDataView;
@property (nonatomic, assign) RefreshCategory category;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) BOOL reloading;

- (void)addHeaderRefreshView;
- (void)addFooterRefreshView;
- (void)removeHeaderAndFooterView;

@end


@implementation PullToRefreshCollectionView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return self;
}

- (void)reloadData{
    [super reloadData];
    float y = self.frame.size.height > self.contentSize.height ? self.frame.size.height : self.contentSize.height;
    _refreshFooterView.frame = CGRectMake(0.0f, y, self.frame.size.width, 650);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public methods

- (void)setRefreshCategory:(RefreshCategory)refreshCategory {
    [self removeHeaderAndFooterView];
    _category = refreshCategory;
    if (refreshCategory == DropdownRefresh) {
        [self addHeaderRefreshView];
    }else if(refreshCategory == PullRefresh){
        [self addFooterRefreshView];
    }else if(refreshCategory == BothRefresh){
        [self addHeaderRefreshView];
        [self addFooterRefreshView];
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

// 此下两个函数是触发动作的开始  即拖拽动作
- (void)customTableViewWillBeginDragging:(UIScrollView *)scrollView{
    _point = scrollView.contentOffset;
}

- (void)customTableViewDidScroll:(UIScrollView *)scrollView{
    if (_reloading) {
        return;
    }
    
    CGPoint pt =scrollView.contentOffset;
    if (_point.y > pt.y) {//向下拉加载更多
        [_refreshHeaderView egoRefreshScrollViewDidScroll:self];
    }else if(!_isLoadedAllTheData){//向上提加载更多 且 没有加载完服务器端数据
        [_refreshFooterView egoRefreshScrollViewDidScroll:self];
    }
    
}

- (void)customTableViewDidEndDragging:(UIScrollView *)scrollView{
    if (_reloading) {
        return;
    }
    
    CGPoint pt =scrollView.contentOffset;
    if (_point.y > pt.y) {//向下拉加载更多
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:self];
    }else if(!_isLoadedAllTheData){ //向上提加载更多 且 没有加载完服务器端数据
        [_refreshFooterView egoRefreshScrollViewDidEndDragging:self];
    }
}

- (void)showNoDataViewWithImage:(UIImage *)image tips:(NSString *)tips {
    if (_noDataView == nil) {
        float screenWidth = [UIScreen mainScreen].bounds.size.width;
        _noDataView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth, self.frame.size.height)];
        _noDataView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _noDataView.backgroundColor = UIColorFromHexColor(0xf2f2f2);
        [self addSubview:_noDataView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth - image.size.width) / 2, self.frame.size.height / 2 - image.size.height - 30, image.size.width, image.size.height)];
        imageView.image = image;
        [_noDataView addSubview:imageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height + imageView.frame.origin.y + 15, screenWidth, 30)];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setText:tips];
        [titleLabel setTextColor:UIColorFromHexColor(0x666666)];
        [_noDataView addSubview:titleLabel];
    }
    _noDataView.hidden = NO;
    [self bringSubviewToFront:_noDataView];
}

- (void)hideNoDataView {
    _noDataView.hidden = YES;
}

- (void)showLoadedAllDataViewWithTips:(NSString *)tips {
    float y = self.frame.size.height > self.contentSize.height ? self.frame.size.height : self.contentSize.height;
    if (_loadedAllDataView == nil) {
        _loadedAllDataView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, y, self.frame.size.width, 650)];
        _loadedAllDataView.backgroundColor = [UIColor clearColor];
        
        UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        tipsLabel.text = tips;
        tipsLabel.textAlignment = NSTextAlignmentCenter;
        tipsLabel.textColor = UIColorFromHexColor(0x999999);
        tipsLabel.font = [UIFont systemFontOfSize:12.0f];
        [_loadedAllDataView addSubview:tipsLabel];
        [self addSubview:_loadedAllDataView];
    }
    _loadedAllDataView.frame = CGRectMake(0.0f, y, self.frame.size.width, 650);
    _loadedAllDataView.hidden = NO;
}

- (void)hideLoadedAllDataView {
    _loadedAllDataView.hidden = YES;
}

- (void)addNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotificationMsg:) name:kGoTopNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptNotificationMsg:) name:kLeaveTopNotificationName object:nil];
}

-(void)acceptNotificationMsg:(NSNotification *)notification{
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:kGoTopNotificationName]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[kIsCanScroll];
        if ([canScroll isEqualToString:kCanScroll]) {
            self.canScroll = YES;
            self.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:kLeaveTopNotificationName]){
        self.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.showsVerticalScrollIndicator = NO;
    }
}

#pragma mark - Data Source Loading / Reloading Methods

- (void)reloadTableViewHeaderDataSource{
    _reloading = YES;
    if (_isLoadedAllTheData) {
        _isLoadedAllTheData = NO;
        [self addSubview:_refreshFooterView];
    }
    DELEGATE_CALLBACK(_customTableDelegate, @selector(getHeaderDataSoure));
}

- (void)reloadTableViewFooterDataSource{
    _reloading = YES;
    DELEGATE_CALLBACK(_customTableDelegate, @selector(getFooterDataSoure));
}

- (void)doneLoadingTableViewData{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
    if (_isLoadedAllTheData && _refreshFooterView != nil) {
        [_refreshFooterView  removeFromSuperview];
    }
}

#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)refreshHeaderViewDidRefreshing:(EGORefreshTableHeaderView *)view {
    [self reloadTableViewHeaderDataSource];
}

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewHeaderDataSource];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];
}

#pragma mark EGORefreshTableFooterDelegate Methods

- (void)egoRefreshTableFooterDidTriggerRefresh:(EGORefreshTableFooterView*)view{
    [self reloadTableViewFooterDataSource];
}


#pragma mark - private methods

- (void)addHeaderRefreshView {
    if (_refreshHeaderView == nil) {
        _refreshHeaderView =  [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.frame.size.height, self.frame.size.width, self.frame.size.height)];
        _refreshHeaderView.backgroundColor = [UIColor clearColor];
        _refreshHeaderView.delegate = self;
    }
    [self addSubview:_refreshHeaderView];

}

- (void)addFooterRefreshView {
    if (_refreshFooterView == nil) {
        float y = self.frame.size.height > self.contentSize.height ? self.frame.size.height : self.contentSize.height;
        _refreshFooterView = [[EGORefreshTableFooterView alloc] initWithFrame: CGRectMake(0.0f, y, self.frame.size.width, 650)];
        _refreshFooterView.delegate = self;
        _refreshFooterView.backgroundColor = [UIColor clearColor];
    }
    [self addSubview:_refreshFooterView];
}

- (void)removeHeaderAndFooterView {
    if(_refreshHeaderView != nil) {
        [_refreshHeaderView removeFromSuperview];
    }
    if(_refreshFooterView != nil) {
        [_refreshFooterView removeFromSuperview];
    }
}

@end
