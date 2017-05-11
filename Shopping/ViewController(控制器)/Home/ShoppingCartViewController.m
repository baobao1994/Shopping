//
//  ShoppingCartViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "UITableViewCell+Addition.h"
#import "ShoopingCartTableViewCell.h"
#import "OrderModel.h"
#import "FoodCollecModel.h"

@interface ShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderList = OrderManagerInstance.orderList;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoopingCartTableViewCell * cell = [ShoopingCartTableViewCell dequeInTable:tableView];
    if (!cell) {
        cell = [ShoopingCartTableViewCell loadFromNib];;
        [cell.addButton addTarget:self action:@selector(didSelectAddBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.cutButton addTarget:self action:@selector(didSelectCutBtn:) forControlEvents:UIControlEventTouchUpInside];
        cell.foodCountTF.delegate = self;
    }
    [cell setContent:self.orderList[indexPath.row]];
    cell.addButton.tag = indexPath.row;
    cell.cutButton.tag = indexPath.row;
    cell.foodCountTF.tag = indexPath.row;
    return cell;
}

#pragma mark - Private Method

- (void)didSelectAddBtn:(UIButton *)sender {
    OrderModel *orderModel = self.orderList[sender.tag];
    FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithOrderModel:orderModel];
    [OrderManagerInstance addFoodCollecOrder:foodCollecModel];
    self.orderList = OrderManagerInstance.orderList;
    [self.tableView reloadData];
}

- (void)didSelectCutBtn:(UIButton *)sender {
    OrderModel *orderModel = self.orderList[sender.tag];
    FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithOrderModel:orderModel];
    [OrderManagerInstance cutFoodCollecOrder:foodCollecModel];
    self.orderList = OrderManagerInstance.orderList;
    [self.tableView reloadData];
}

@end
