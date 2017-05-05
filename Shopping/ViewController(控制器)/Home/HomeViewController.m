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

#import "FoodListViewController.h"

NSString *const HomeCollectionViewCellIdentifier = @"HomeCollectionViewCell";
NSString *const HomeHeaderCollectionReusableViewIdentifier = @"HomeHeaderCollectionReusableView";
NSString *const HomeFooterCollectionReusableViewIdentifier = @"HomeFooterCollectionReusableView";

@interface HomeViewController () <UICollectionViewDelegate,UICollectionViewDataSource,PullToRefreshCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *bannerArr;
@property (nonatomic, strong) NSMutableArray *foodlist;
@property (nonatomic, assign) NSInteger requestCount;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUp];
    [self getHeaderDataSoure];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FoodListViewController *foodListVC = [[FoodListViewController alloc] init];
    [self.navigationController pushViewController:foodListVC animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(UIScreenWidth, 120 * UIScreenWidth / 320);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(UIScreenWidth, 50);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.foodlist.count;
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
        reusableView = footer;
    }
    return reusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HomeCollectionViewCellIdentifier forIndexPath:indexPath];
    [cell setConent:self.foodlist[indexPath.row]];
    return cell;
}

#pragma mark - PullToRefreshCollectionViewDelegate method

- (void)getHeaderDataSoure {
    self.requestCount = 0;
    [self requestBanner];
    [self requestHomeFoodList];
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
    self.bannerArr = [[NSMutableArray alloc] init];
    self.foodlist = [[NSMutableArray alloc] init];
    _collectionView.customTableDelegate = self;
    [_collectionView setRefreshCategory:DropdownRefresh];
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
            [self doneLoad];
        } else {
            [MBProgrossManagerInstance showErrorOnlyText:@"网络错误" HudHiddenCallBack:^{
                
            }];
        }
    }];
}

- (void)requestHomeFoodList {
    BmobQuery *query = [BmobQuery queryWithClassName:HomeFoodListTable];
    [query findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            [self.foodlist removeAllObjects];
            for (BmobObject *obj in array) {
                FoodListModel *foodListModel = [[FoodListModel alloc] initWithDictionary:(NSDictionary *)obj];
                [self.foodlist addObject:foodListModel];
            }
            self.requestCount ++;
            [self doneLoad];
        } else {
            [MBProgrossManagerInstance showErrorOnlyText:@"网络错误" HudHiddenCallBack:^{
                
            }];
        }
    }];
}

- (void)doneLoad {
    if (self.requestCount == 2) {
        [self.collectionView doneLoadingTableViewData];
        [self.collectionView reloadData];
    }
}

@end
