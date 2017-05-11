//
//  FoodListViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "FoodListViewController.h"
#import "UITableViewCell+Addition.h"
#import "FoodCategoryModel.h"
#import "FoodCollecModel.h"
#import "HorizontalScrollTableViewCell.h"
#import "HorizonItemCollectionViewCell.h"
#import "HorizonItemHFCollectionViewCell.h"
#import "ConstString.h"
#import "CustomAlertView.h"
#import "FoodDetailShowView.h"
#import "PullToRefreshTableView.h"
#import "FoodSecTypeListModel.h"
#import "UIViewController+Pop.h"
#import "ShoppingCartViewController.h"
#import "ConfirmOrderViewController.h"

NSString *const HorizonItemCollectionViewCellIdentifier = @"HorizonItemCollectionViewCell";
NSString *const HorizonItemHFCollectionViewCellIdentifier = @"HorizonItemHFCollectionViewCell";

@interface FoodListViewController ()<HorizontalScrollCellDelegate,UITableViewDelegate,UITableViewDataSource,PullToRefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *secTypeSource;
@property (nonatomic, strong) CustomAlertView *customAlertView;
@property (nonatomic, strong) FoodDetailShowView *foodDetailShowView;

@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self getHeaderDataSoure];
    [self createNavigationRightItem:@"setting"];
}

- (void)selectedNavigationRightItem:(id)sender {
    ShoppingCartViewController *shoppingCartVC = [[ShoppingCartViewController alloc] init];
    [self.navigationController pushViewController:shoppingCartVC animated:YES];
}

#pragma mark - PullToRefreshTableViewDelegate method

- (void)getHeaderDataSoure {
    BmobQuery *foodCategoryQuery = [BmobQuery queryWithClassName:FoodSecTypeListTable];
    [foodCategoryQuery whereKey:FoodSecTypeListFoodTypeKey equalTo:self.foodTypeId];
    [foodCategoryQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.dataSource removeAllObjects];
        [self.secTypeSource removeAllObjects];
        for (BmobObject *obj in array) {
            FoodCategoryModel *foodCategoryModel = [[FoodCategoryModel alloc] initWithDictionary:(NSDictionary *)obj];
            foodCategoryModel.contentOffset = CGPointZero;
            foodCategoryModel.animate = YES;
            FoodSecTypeListModel *foodSecTypeListModel = [[FoodSecTypeListModel alloc] initWithDictionary:(NSDictionary *)obj];
            foodCategoryModel.foodSecType = foodSecTypeListModel.type;
            [self.dataSource addObject:foodCategoryModel];
            [self.secTypeSource addObject:foodSecTypeListModel];
        }
        BmobQuery *foodCollecQuery = [BmobQuery queryWithClassName:FoodCollecTable];
        [foodCollecQuery whereKey:FoodSecTypeListFoodTypeKey equalTo:self.foodTypeId];
        [foodCollecQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            for (FoodCategoryModel *foodCategoryModel in self.dataSource) {
                NSString *foodSecType = foodCategoryModel.foodSecType;
                for (int i = 0; i < array.count; i ++) {
                    FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithDictionary:(NSDictionary *)array[i]];
                    if ([foodCollecModel.foodSecType isEqualToString:foodSecType]) {
                        [foodCategoryModel.foodCategorylist addObject:foodCollecModel];
                    }
                }
            }
            [self.tableView doneLoadingTableViewData];
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - UITableView Delegate method

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.tableView customTableViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.tableView customTableViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView customTableViewDidEndDragging:scrollView];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 140.0f;
    if (_type == CenterTableViewGoods) {
        height = UIScreenHeight - 64 - 5;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.01f;
    if (_type == CenterTableViewTopic) {
        if (section == self.secTypeSource.count - 1) {
            height = 10.0f;
        }
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 10)];
    headerView.backgroundColor = UIColorFromHexColor(0XFFFFFF);
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.01)];
    footerView.backgroundColor = UIColorFromHexColor(0XFFFFFF);
    return footerView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = self.dataSource.count;
    if (_type == CenterTableViewGoods) {
        if (self.dataSource.count) {
            count = 1;
        } else {
            count = 0;
        }
    }
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HorizontalScrollTableViewCell * cell = [HorizontalScrollTableViewCell dequeInTable:tableView];
    if (!cell) {
        cell = [HorizontalScrollTableViewCell loadFromNib];
        [cell.collectionView registerNib:[UINib nibWithNibName:@"HorizonItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HorizonItemCollectionViewCellIdentifier];
        [cell.collectionView registerNib:[UINib nibWithNibName:@"HorizonItemHFCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:HorizonItemHFCollectionViewCellIdentifier];
        UICollectionViewFlowLayout *horizontalCellLayout = [[UICollectionViewFlowLayout alloc] init];
        if (_type == CenterTableViewTopic) {
            horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else {
            horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 21, 0, 21);
        cell.collectionView.collectionViewLayout = horizontalCellLayout;
        cell.delegate = self;
        cell.contentOffset = CGPointZero;
    }
    FoodCategoryModel *foodCategoryModel = self.dataSource[indexPath.section];
    cell.contentOffset = foodCategoryModel.contentOffset;
    cell.animate = foodCategoryModel.animate;
    cell.tableViewIndexPath = indexPath;
    cell.collectionView.tag = indexPath.section;
    [cell reloadData];
    return cell;
}

#pragma mark - HorizontalScrollCellDelegate

- (NSInteger)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView numberOfItemsInTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    FoodCategoryModel *foodcategoryModel = self.dataSource[tableViewIndexPath.section];
    NSInteger count = foodcategoryModel.foodCategorylist.count;
    if (_type == CenterTableViewTopic) {
        count += 1;
    }
    return count;
}

- (UICollectionViewCell *)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView cellForItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    NSInteger section = tableViewIndexPath.section;
    NSInteger row = contentIndexPath.row;
    UICollectionViewCell *cell;
    if (_type == CenterTableViewTopic) {
        if (row == 0) {
            cell = (HorizonItemHFCollectionViewCell *)[horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemHFCollectionViewCellIdentifier forIndexPath:contentIndexPath];
            [((HorizonItemHFCollectionViewCell *)cell) setConent:self.secTypeSource[section]];
            cell.backgroundColor = RandomColor;
        } else {
            cell = [horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemCollectionViewCellIdentifier forIndexPath:contentIndexPath];
            FoodCategoryModel *foodCategoryModel = self.dataSource[section];
            [((HorizonItemCollectionViewCell *)cell) setConent:foodCategoryModel.foodCategorylist[row - 1]];
            cell.backgroundColor = RandomColor;
        }
    } else {
        cell = [horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemCollectionViewCellIdentifier forIndexPath:contentIndexPath];
        FoodCategoryModel *foodCategoryModel = self.dataSource[section];
        [((HorizonItemCollectionViewCell *)cell) setConent:foodCategoryModel.foodCategorylist[row]];
        cell.backgroundColor = RandomColor;
    }
    return cell;
}

- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(80, 140);
    if (_type == CenterTableViewTopic) {
        if (indexPath.row != 0) {
            itemSize.width = 100;
        }
    } else {
        itemSize.width = UIScreenWidth - 42;
    }
    return itemSize;
}

- (void)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView didSelectItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath {
    [horizontalCellContentsView deselectItemAtIndexPath:contentIndexPath animated:YES];
    NSInteger section = tableViewIndexPath.section;
    NSInteger item = contentIndexPath.item;
    FoodCategoryModel *foodCategoryModel = self.dataSource[section];
    if (_type == CenterTableViewTopic) {
        if (item == 0) {
            [MBProgrossManagerInstance showOnlyText:foodCategoryModel.name HudHiddenCallBack:nil];
        } else {
            self.foodDetailShowView.currentIndex = item - 1;
            self.foodDetailShowView.dateSource = foodCategoryModel.foodCategorylist;
            [self.foodDetailShowView reload];
            [self.customAlertView show];
        }
    } else {
        self.foodDetailShowView.currentIndex = item;
        self.foodDetailShowView.dateSource = foodCategoryModel.foodCategorylist;
        [self.foodDetailShowView reload];
        [self.customAlertView show];
    }
//    NSLog(@"Section %ld Row %ld Item %ld is selected", (unsigned long)tableViewIndexPath.section, (unsigned long)tableViewIndexPath.row, (unsigned long)contentIndexPath.item);
}

- (void)contentOffset:(CGPoint)contentOffset atIndex:(NSInteger)atIndex {
    FoodCategoryModel *foodCategoryModel = self.dataSource[atIndex];
    foodCategoryModel.contentOffset = contentOffset;
    foodCategoryModel.animate = NO;
}

#pragma mark - Private Method

- (void)setUp {
    WEAKSELF_SC;
    self.tableView.customTableDelegate = self;
    [self.tableView setRefreshCategory:DropdownRefresh];
    self.dataSource = [[NSMutableArray alloc] init];
    self.secTypeSource = [[NSMutableArray alloc] init];
    self.foodDetailShowView = [[FoodDetailShowView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth - 60, UIScreenHeight * 2 / 3)];
    [self.foodDetailShowView setToGoBuy:^{
        [weakSelf_SC hideFoodDetailShowView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            ConfirmOrderViewController *confirmOrderVC = [[ConfirmOrderViewController alloc] init];
            [weakSelf_SC.navigationController pushViewController:confirmOrderVC animated:YES];
        });
    }];
    [self.foodDetailShowView.closeButton addTarget:self action:@selector(hideFoodDetailShowView) forControlEvents:UIControlEventTouchUpInside];
    self.customAlertView = [[CustomAlertView alloc] init];
    self.customAlertView.contentView = self.foodDetailShowView;
}

- (void)hideFoodDetailShowView {
    [self.foodDetailShowView.collectionView setContentOffset:CGPointZero animated:NO];
    [self.customAlertView hide];
}

@end
