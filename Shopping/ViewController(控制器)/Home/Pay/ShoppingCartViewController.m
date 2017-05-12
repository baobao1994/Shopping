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
#import "UIViewController+Pop.h"
#import "ScottAlertController.h"
#import "ConfirmOrderViewController.h"

@interface ShoppingCartViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.orderList = OrderManagerInstance.orderList;
    [self createNavigationRightItem:@"setting"];
    [self culculateOrder];
}

- (void)selectedNavigationRightItem:(id)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"清空购物车" message:@""];
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
    }]];
    [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
    }]];
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleDropDown];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
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
    [self culculateOrder];
}

- (void)didSelectCutBtn:(UIButton *)sender {
    OrderModel *orderModel = self.orderList[sender.tag];
    FoodCollecModel *foodCollecModel = [[FoodCollecModel alloc] initWithOrderModel:orderModel];
    if (orderModel.count == 1) {
        ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:[NSString stringWithFormat:@"%@",foodCollecModel.name] message:@"仅剩一件,是否清空?"];
        [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        }]];
        [alertView addAction:[ScottAlertAction actionWithTitle:@"确定" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
            [self cutOrder:foodCollecModel];
        }]];
        ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleAlert transitionAnimationStyle:ScottAlertTransitionStyleDropDown];
        alertController.tapBackgroundDismissEnable = YES;
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self cutOrder:foodCollecModel];
    }
}

- (void)cutOrder:(FoodCollecModel *)foodCollecModel {
    [OrderManagerInstance cutFoodCollecOrder:foodCollecModel];
    self.orderList = OrderManagerInstance.orderList;
    [self.tableView reloadData];
    [self culculateOrder];
}

- (void)culculateOrder {
    float price = 0.00;
    float couponPrice = 0;
    for (OrderModel *orderModel in self.orderList) {
        price += [orderModel.foodPrice floatValue];
        if (orderModel.count >= orderModel.couponCount) {
            couponPrice += [orderModel.couponPrice floatValue] * orderModel.couponCount;
        } else {
            couponPrice = [orderModel.couponPrice floatValue];
        }
    }
    self.orderPriceLabel.text = [NSString stringWithFormat:@"一共需要支付%.2f元,已优惠%.2f元",price,couponPrice];
}

- (IBAction)didSelectBuyBtn:(UIButton *)sender {
    ConfirmOrderViewController *confirmOrderVC = [[ConfirmOrderViewController alloc] init];
    [self.navigationController pushViewController:confirmOrderVC animated:YES];
}

@end
