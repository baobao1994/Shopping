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
#import "ConstString.h"

NSString *const HorizonItemCollectionViewCellIdentifier = @"HorizonItemCollectionViewCell";

typedef NS_ENUM(NSUInteger, CenterTableViewType) {
    CenterTableViewTopic,
    CenterTableViewGoods,
};

@interface FoodListViewController ()<HorizontalScrollCellDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CenterTableViewType type;
@property (nonatomic, assign) NSInteger requestCount;

@end

@implementation FoodListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"美食列表";
    self.dataSource = [[NSMutableArray alloc] init];
    BmobQuery *foodCategoryQuery = [BmobQuery queryWithClassName:FoodcategoryTable];
    [foodCategoryQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.dataSource removeAllObjects];
        self.requestCount ++;
        for (BmobObject *obj in array) {
            [self.dataSource addObject:[[FoodCategoryModel alloc] initWithDictionary:(NSDictionary *)obj]];
        }
        BmobQuery *foodCollecQuery = [BmobQuery queryWithClassName:FoodCollecTable];
        [foodCollecQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            self.requestCount ++;
            for (FoodCategoryModel *foodCategoryModel in self.dataSource) {
                NSString *foodCategoryId = foodCategoryModel.foodCategoryId;
                for (int i = 0; i < array.count; i ++) {
                    FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithDictionary:(NSDictionary *)array[i]];
                    if ([foodCollecModel.foodCategoryId isEqualToString:foodCategoryId]) {
                        [foodCategoryModel.foodCategorylist addObject:foodCollecModel];
                    }
                }
            }
            [self requestFinish];
        }];
    }];
}

- (void)requestFinish {
    if (self.requestCount == 2) {
        [self.tableView reloadData];
    }
}

#pragma mark - UITableView Delegate method

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    [self.tableView customTableViewWillBeginDragging:scrollView];
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self.tableView customTableViewDidScroll:scrollView];
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    [self.tableView customTableViewDidEndDragging:scrollView];
//}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
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
        UICollectionViewFlowLayout *horizontalCellLayout = [[UICollectionViewFlowLayout alloc] init];
        horizontalCellLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        horizontalCellLayout.sectionInset = UIEdgeInsetsMake(0, 21, 0, 21);
        cell.collectionView.collectionViewLayout = horizontalCellLayout;
        cell.delegate = self;
    }
    cell.backgroundColor = RandomColor;
    cell.tableViewIndexPath = indexPath;
    return cell;
}

#pragma mark - HorizontalScrollCellDelegate

- (NSInteger)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView numberOfItemsInTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    FoodCategoryModel *foodcategoryModel = self.dataSource[tableViewIndexPath.section];
    NSInteger count = foodcategoryModel.foodCategorylist.count;
    if (count > 4) {
        return 7;
    }
    return count +1;
}

- (UICollectionViewCell *)horizontalCellContentsView:(UICollectionView *)horizontalCellContentsView cellForItemAtContentIndexPath:(NSIndexPath *)contentIndexPath inTableViewIndexPath:(NSIndexPath *)tableViewIndexPath{
    HorizonItemCollectionViewCell *cell = [horizontalCellContentsView dequeueReusableCellWithReuseIdentifier:HorizonItemCollectionViewCellIdentifier forIndexPath:contentIndexPath];
    cell.backgroundColor = RandomColor;
    return cell;
}

- (CGSize)horizontalCellContentsView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeMake(70, 140);
    if (_type == CenterTableViewTopic) {
        itemSize.width = 312/2;
        itemSize.height = itemSize.height-20;
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
    NSLog(@"Section %ld Row %ld Item %ld is selected", (unsigned long)tableViewIndexPath.section, (unsigned long)tableViewIndexPath.row, (unsigned long)contentIndexPath.item);
}

#pragma mark - Private Method

- (NSMutableArray *)loadDataByType:(CenterTableViewType )type {
    NSArray *nameArray = @[@"办公",@"厨具",@"创意",@"护肤",@"家居",@"美食",@"数码",@"卫浴",@"运动",@"杂货",@"植物",@"主题"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    [nameArray enumerateObjectsUsingBlock:^(NSString *objname, NSUInteger idx, BOOL *stop) {
        FoodCategoryModel *categoty = [[FoodCategoryModel alloc] init];
        categoty.foodCategoryName = objname;
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:10];
        for (int i = 0 ; i< 5; i++) {
            FoodCollecModel *item = [[FoodCollecModel alloc] init];
            item.foodCollecName = [NSString stringWithFormat:@"%@--(%ld)",objname,i*idx];
            item.foodCollecPrice = [NSString stringWithFormat:@"￥%ld",(i+1)*(idx+1)*2];
            [itemArray addObject:item];
        }
        categoty.foodCategorylist = itemArray;
        [array addObject:categoty];
    }];
    [self.tableView reloadData];
    return  array;
}

@end
