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
#import "ConstString.h"
#import "BannerModel.h"
#import "FoodListModel.h"
#import "SystemInfoModel.h"
#import "FoodListViewController.h"
#import "UICollectionView+Gzw.h"

NSString *const HomeCollectionViewCellIdentifier = @"HomeCollectionViewCell";
NSString *const HomeHeaderCollectionReusableViewIdentifier = @"HomeHeaderCollectionReusableView";
NSString *const HomeFooterCollectionReusableViewIdentifier = @"HomeFooterCollectionReusableView";

@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,PullToRefreshCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *foodCategorylist;
@property (nonatomic, strong) SystemInfoModel *systemInfoModel;
@property (nonatomic, assign) NSInteger requestCount;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUp];
    [self getHeaderDataSoure];
    [_collectionView gzwLoading:^{
        [self getHeaderDataSoure];
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodListViewController *foodListVC = [[FoodListViewController alloc] init];
    FoodListModel *foodListModel = self.foodCategorylist[indexPath.row];
    foodListVC.foodTypeId = foodListModel.type;
    foodListVC.title = foodListModel.name;
    foodListVC.type = foodListModel.showType;
    [self.navigationController pushViewController:foodListVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(UIScreenWidth, 120 * UIScreenWidth / 320);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeZero;
    if (!isEmptyString(self.systemInfoModel.homeBottomTip)) {
        size = CGSizeMake(UIScreenWidth, 40);
    }
    return size;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodCategorylist.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        HomeHeaderCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeHeaderCollectionReusableViewIdentifier forIndexPath:indexPath];
        reusableView = header;
        [header setUpImage:self.bannerArr];
    }
    if (kind == UICollectionElementKindSectionFooter) {
        HomeFooterCollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HomeFooterCollectionReusableViewIdentifier forIndexPath:indexPath];
        footer.tipLabel.text = self.systemInfoModel.homeBottomTip;
        reusableView = footer;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setConent:self.foodCategorylist[indexPath.row]];
    return cell;
}

#pragma mark - PullToRefreshCollectionViewDelegate method

- (void)getHeaderDataSoure {
    self.requestCount = 0;
    [self requestBanner];
    [self requestHomeFoodList];
    [self requestSystemInfo];
}

#pragma mark - PriveMothd

- (void)setUp {
    [_collectionView registerNib:[UINib nibWithNibName:@"HomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HomeCollectionViewCellIdentifier];
    [self.collectionView registerClass:[HomeHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HomeHeaderCollectionReusableViewIdentifier];
    [self.collectionView registerClass:[HomeFooterCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HomeFooterCollectionReusableViewIdentifier];
    UICollectionViewFlowLayout *lotteryLayout = [[UICollectionViewFlowLayout alloc] init];
    lotteryLayout.itemSize = CGSizeMake((UIScreenWidth - 90) / 2, (UIScreenWidth - 90) / 2);
    lotteryLayout.sectionInset = UIEdgeInsetsMake(30, 30, 30, 30);
    self.collectionView.collectionViewLayout = lotteryLayout;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = YES;
    _collectionView.customTableDelegate = self;
    [_collectionView setRefreshCategory:DropdownRefresh];
    if (UserManagerInstance.bannerArrInfo) {
       self.bannerArr = UserManagerInstance.bannerArrInfo;
    } else {
        self.bannerArr = [[NSMutableArray alloc] init];
    }
    if (UserManagerInstance.foodCategoryArrInfo) {
        self.foodCategorylist = UserManagerInstance.foodCategoryArrInfo;
    } else {
        self.foodCategorylist = [[NSMutableArray alloc] init];
        [self loadingData:NO];
    }
    self.systemInfoModel = UserManagerInstance.systemInfo;
    [self.collectionView reloadData];
}

- (void)requestBanner {
    BmobQuery *query = [BmobQuery queryWithClassName:BannerTable];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            [self.bannerArr removeAllObjects];
            for (BmobObject *obj in array) {
                BannerModel *bannerModel = [[BannerModel alloc] initWithDictionary:(NSDictionary *)obj];
                [self.bannerArr addObject:bannerModel];
            }
            self.requestCount ++;
            if (array.count) {
                [UserManagerInstance saveBannerArrInfo:self.bannerArr];
            }
            [self doneLoad];
        } else {
            [MBProgrossManagerInstance showErrorOnlyText:@"网络错误,请检查网络" HudHiddenCallBack:^{
                [self.collectionView doneLoadingTableViewData];
            }];
        }
    }];
}

- (void)requestHomeFoodList {
    BmobQuery *query = [BmobQuery queryWithClassName:HomeFoodListTable];
    [query orderByAscending:FoodListTypeKey];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            [self.foodCategorylist removeAllObjects];
            for (BmobObject *obj in array) {
                FoodListModel *foodListModel = [[FoodListModel alloc] initWithDictionary:(NSDictionary *)obj];
                [self.foodCategorylist addObject:foodListModel];
            }
            if (array.count) {
                [UserManagerInstance saveFoodCategoryArrInfo:self.foodCategorylist];
            }
            self.requestCount ++;
            [self doneLoad];
        } else {
            [MBProgrossManagerInstance showErrorOnlyText:@"网络错误,请检查网络" HudHiddenCallBack:^{
                [self.collectionView doneLoadingTableViewData];
            }];
        }
    }];
}

- (void)requestSystemInfo {
    BmobQuery *systemQuery = [BmobQuery queryWithClassName:SystemTable];
    [systemQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            self.systemInfoModel = [[SystemInfoModel alloc] initWithDictionary:(NSDictionary *)array[0]];
            [UserManagerInstance saveSystemInfo:self.systemInfoModel];
            self.requestCount ++;
            [self doneLoad];
        }
    }];
}

- (void)doneLoad {
    if (self.requestCount == 3) {
        [self.collectionView doneLoadingTableViewData];
        [self.collectionView reloadData];
    }
}

-(void)loadingData:(BOOL)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.collectionView.loading = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!data) {
                self.collectionView.loading = NO;
            }
            [self.collectionView reloadData];
        });
    });
}

@end
