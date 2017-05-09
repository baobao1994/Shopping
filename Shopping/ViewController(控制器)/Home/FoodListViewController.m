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

NSString *const HorizonItemCollectionViewCellIdentifier = @"HorizonItemCollectionViewCell";
NSString *const HorizonItemHFCollectionViewCellIdentifier = @"HorizonItemHFCollectionViewCell";

typedef NS_ENUM(NSUInteger, CenterTableViewType) {
    CenterTableViewTopic,
    CenterTableViewGoods,
};

@interface FoodListViewController ()<HorizontalScrollCellDelegate,UITableViewDelegate,UITableViewDataSource,PullToRefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *secTypeSource;
@property (nonatomic, assign) CenterTableViewType type;
@property (nonatomic, strong) CustomAlertView *customAlertView;
@property (nonatomic, strong) FoodDetailShowView *foodDetailShowView;
@property (nonatomic, strong) NSMutableArray *isShouldReloadArr;

@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    [self getHeaderDataSoure];
}

#pragma mark - PullToRefreshTableViewDelegate method

- (void)getHeaderDataSoure {
    BmobQuery *foodCategoryQuery = [BmobQuery queryWithClassName:FoodSecTypeListTable];
    [foodCategoryQuery whereKey:FoodSecTypeListFoodTypeKey equalTo:self.foodTypeId];
    [foodCategoryQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.dataSource removeAllObjects];
        [self.secTypeSource removeAllObjects];
        [self.isShouldReloadArr removeAllObjects];
        for (BmobObject *obj in array) {
            FoodCategoryModel *foodCategoryModel = [[FoodCategoryModel alloc] initWithDictionary:(NSDictionary *)obj];
            FoodSecTypeListModel *foodSecTypeListModel = [[FoodSecTypeListModel alloc] initWithDictionary:(NSDictionary *)obj];
            foodCategoryModel.foodSecType = foodSecTypeListModel.type;
            [self.dataSource addObject:foodCategoryModel];
            [self.secTypeSource addObject:foodSecTypeListModel];
            [self.isShouldReloadArr addObject:[NSNumber numberWithBool:YES]];
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
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.01f;
    if (section == self.secTypeSource.count - 1) {
        height = 10.0f;
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
    return self.dataSource.count;
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
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 21, 0, 21);
        cell.collectionView.collectionViewLayout = horizontalCellLayout;
        cell.delegate = self;
    }
    BOOL isShouldReload = self.isShouldReloadArr[indexPath.section];
    if (isShouldReload) {
        [cell reloadData];
        self.isShouldReloadArr[indexPath.section] = [NSNumber numberWithBool:NO];
    }
    cell.backgroundColor = RandomColor;
    cell.tableViewIndexPath = indexPath;
    return cell;
}

#pragma mark - HorizontalScrollCellDelegate

- (NSInteger)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView numberOfItemsInTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    FoodCategoryModel *foodcategoryModel = self.dataSource[tableViewIndexPath.section];
    NSInteger count = foodcategoryModel.foodCategorylist.count;
    if (count > 5) {
        count = 7;
    } else {
        count += 1;
    }
    return count;
}

- (UICollectionViewCell *)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView cellForItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    NSInteger section = tableViewIndexPath.section;
    NSInteger row = contentIndexPath.row;
    FoodCategoryModel *foodcategoryModel = self.dataSource[section];
    NSInteger count = foodcategoryModel.foodCategorylist.count;
    UICollectionViewCell *cell;
    if (row == 0) {
        cell = (HorizonItemHFCollectionViewCell *)[horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemHFCollectionViewCellIdentifier forIndexPath:contentIndexPath];
        [((HorizonItemHFCollectionViewCell *)cell) setConent:self.secTypeSource[section]];
        cell.backgroundColor = RandomColor;
    } else {
        if (count >= 6 && row == 6) {
            cell = (HorizonItemHFCollectionViewCell *)[horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemHFCollectionViewCellIdentifier forIndexPath:contentIndexPath];
            cell.backgroundColor = [UIColor yellowColor];
            ((HorizonItemHFCollectionViewCell *)cell).nameLabel.text = @"更多";
        } else {
            cell = [horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemCollectionViewCellIdentifier forIndexPath:contentIndexPath];
            FoodCategoryModel *foodCategoryModel = self.dataSource[section];
            [((HorizonItemCollectionViewCell *)cell) setConent:foodCategoryModel.foodCategorylist[row - 1]];
            cell.backgroundColor = RandomColor;
        }
    }
    return cell;
}

- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(70, 140);
    if (_type == CenterTableViewTopic) {
        itemSize.width = 312/2;
        itemSize.height = itemSize.height - 20;
    } else {
        itemSize.width = 70;
    }
    if (indexPath.row == 0 ||indexPath.row == 6) {
        return CGSizeMake(70, itemSize.height);
    }
    return itemSize;
}

- (void)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView didSelectItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath {
    [horizontalCellContentsView deselectItemAtIndexPath:contentIndexPath animated:YES];
    NSInteger section = tableViewIndexPath.section;
    NSInteger item = contentIndexPath.item;
    if (item == 0) {
        //这里可以弹出这个类别的说明，比如说功效说明
    } else if (item == 6) {
        
    } else {
        [self.customAlertView show];
    }
    NSLog(@"Section %ld Row %ld Item %ld is selected", (unsigned long)tableViewIndexPath.section, (unsigned long)tableViewIndexPath.row, (unsigned long)contentIndexPath.item);
}

#pragma mark - Private Method

- (void)setUp {
    self.tableView.customTableDelegate = self;
    [self.tableView setRefreshCategory:DropdownRefresh];
    self.isShouldReloadArr = [[NSMutableArray alloc] init];
    self.dataSource = [[NSMutableArray alloc] init];
    self.secTypeSource = [[NSMutableArray alloc] init];
    self.foodDetailShowView = [[FoodDetailShowView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth - 60, 180)];
    [self.foodDetailShowView.closeButton addTarget:self action:@selector(hideFoodDetailShowView) forControlEvents:UIControlEventTouchUpInside];
    self.customAlertView = [[CustomAlertView alloc] init];
    self.customAlertView.contentView = self.foodDetailShowView;
}

- (void)hideFoodDetailShowView {
    [self.customAlertView hide];
}

@end
