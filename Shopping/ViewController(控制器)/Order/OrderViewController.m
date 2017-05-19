//
//  OrderViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderViewController.h"
#import "CartOrderModel.h"
#import "FoodCollecModel.h"
#import "OrderTableViewCell.h"
#import "OrderModel.h"
#import "PullToRefreshTableView.h"
#import "UITableView+Gzw.h"
#import "UITableViewCell+Addition.h"
#import "ConstString.h"
#import "UserInfoModel.h"
#import "LoginViewController.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,PullToRefreshTableViewDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshTableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderList = [[NSMutableArray alloc] init];
    _tableView.customTableDelegate = self;
    [_tableView setRefreshCategory:DropdownRefresh];
    _tableView.loading = YES;
    [_tableView gzwLoading:^{
        if ([_tableView.buttonText isEqualToString:@"点击登录"]) {
            [self pushLoginViewController];
        } else {
            self.tabBarController.selectedIndex = 0;
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UserManagerInstance.userInfo.userObjectId) {
        [self getHeaderDataSoure];
    } else {
        _tableView.descriptionText = @"请登录";
        _tableView.buttonText = @"点击登录";
        [self loadingData:NO];
    }
}

#pragma mark - PullToRefreshTableViewDelegate method

- (void)getHeaderDataSoure {
    [self reloadList];
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
    return 67.0f;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell * cell = [OrderTableViewCell dequeInTable:tableView];
    if (!cell) {
        cell = [OrderTableViewCell loadFromNib];
    }
    [cell setContent:self.orderList[indexPath.row]];
    return cell;
}

#pragma mark - Private Method

- (void)reloadList {
    BmobQuery *orderQuery = [BmobQuery queryWithClassName:OrderTable];
    orderQuery.limit = 5;//每组5最多5条数据
    orderQuery.skip = 0;//第一组
    [orderQuery orderByDescending:CreatedAtKey];
    [orderQuery whereKey:UserObjectIdKey equalTo:UserManagerInstance.userInfo.userObjectId];
    [orderQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            [_tableView doneLoadingTableViewData];
            [self.orderList removeAllObjects];
            if (array.count) {
                for (BmobObject *obj in array) {
                    OrderModel *orderModel = [[OrderModel alloc] initWithDictionary:(NSDictionary *)obj];
                    [self.orderList addObject:orderModel];
                }
                [self loadingData:YES];
            } else {
                _tableView.descriptionText = @"没有订单";
                _tableView.buttonText = @"点击购买";
                [self loadingData:NO];
            }
        }
    }];
}

-(void)loadingData:(BOOL)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.tableView.loading = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!data) {
                self.tableView.loading = NO;
            }
            [self.tableView reloadData];
        });
    });
}

- (void)pushLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
