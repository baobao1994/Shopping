//
//  ConfirmOrderViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "UITableViewCell+Addition.h"
#import "PayOrderTableViewCell.h"
#import "PayAddreessTableViewCell.h"
#import "PayCouponTableViewCell.h"
#import "PayPriceTableViewCell.h"
#import "MyAddressViewController.h"
#import "AddressModel.h"
#import "ScottAlertController.h"

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *orderList;
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, assign) BOOL isInTheShopEat;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单确认";
    self.orderList = OrderManagerInstance.orderList;
    self.isInTheShopEat = YES;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    CGFloat height = 0;
    switch (section) {
        case 0:
            height = 50.0f;//订单高度
            break;
        case 1:
            if (self.isInTheShopEat) {
                height = 50.0f;//店里吃
            } else {
                height = 100.0f;//不是店里吃
            }
            break;
        case 2:
            height = 50.0f;//优惠条件
            break;
        case 3:
            height = 95.0f;//合计
            break;
        default:
            break;
    }

    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.01f;
    if (section == 3) {
        height = 10.0f;
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 10)];
    headerView.backgroundColor = UIColorFromHexColor(0XF1F1F1);
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.01)];
    footerView.backgroundColor = UIColorFromHexColor(0XF1F1F1);
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rowCount = 1;
    if (section == 0) {
        rowCount = self.orderList.count;
    }
    return rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    UITableViewCell *cell;
    switch (section) {
        case 0:
            cell = [PayOrderTableViewCell dequeInTable:tableView];
            if (!cell) {
                cell = [PayOrderTableViewCell loadFromNib];
            }
            [((PayOrderTableViewCell *)cell) setContent:self.orderList[indexPath.row]];
            break;
        case 1:
            cell = [PayAddreessTableViewCell dequeInTable:tableView];
            if (!cell) {
                cell = [PayAddreessTableViewCell loadFromNib];
                [((PayAddreessTableViewCell *)cell).inTheShopButton addTarget:self action:@selector(didChangeEatAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
                [((PayAddreessTableViewCell *)cell).outTheShopButton addTarget:self action:@selector(didChangeEatAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
                [((PayAddreessTableViewCell *)cell).changeAddressButton addTarget:self action:@selector(didSelectAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (self.isInTheShopEat) {
                ((PayAddreessTableViewCell *)cell).inTheShopButton.selected = YES;
                ((PayAddreessTableViewCell *)cell).outTheShopButton.selected = NO;
            } else {
                ((PayAddreessTableViewCell *)cell).inTheShopButton.selected = NO;
                ((PayAddreessTableViewCell *)cell).outTheShopButton.selected = YES;
            }
            [((PayAddreessTableViewCell *)cell) setContent:self.addressModel];
            break;
        case 2:
            cell = [PayCouponTableViewCell dequeInTable:tableView];
            if (!cell) {
                cell = [PayCouponTableViewCell loadFromNib];
            }
            break;
        case 3:
            cell = [PayPriceTableViewCell dequeInTable:tableView];
            if (!cell) {
                cell = [PayPriceTableViewCell loadFromNib];
            }
            [((PayPriceTableViewCell *)cell) setContent:self.orderList];
            break;
        default:
            break;
    }
    return cell;
}

#pragma mark - Private Method

- (void)didChangeEatAddressBtn:(UIButton *)sender {
    if (sender.tag == 0) {
        self.isInTheShopEat = YES;
    } else {
        self.isInTheShopEat = NO;
    }
    [self.tableView reloadData];
}

- (void)didSelectAddressBtn:(UIButton *)sender {
    WEAKSELF_SC;
    MyAddressViewController *myAddressVC = [[MyAddressViewController alloc] init];
    myAddressVC.isSelectAddress = YES;
    [myAddressVC setChangeAddress:^(AddressModel *addressModel){
        weakSelf_SC.addressModel = addressModel;
        [weakSelf_SC.tableView reloadData];
    }];
    [self.navigationController pushViewController:myAddressVC animated:YES];
}

- (IBAction)didSelectToPay:(id)sender {
    ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"ScottActionSheet" message:@"This is a message, the alert view style is actionsheet. "];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"余额支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"微信支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"支付宝支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
//    [alertView addAction:[ScottAlertAction actionWithTitle:@"删除" style:ScottAlertActionStyleDestructive handler:^(ScottAlertAction *action) {
//        NSLog(@"%@",action.title);
//    }]];
    
    [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
        NSLog(@"%@",action.title);
    }]];
    
    ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleActionSheet];
    alertController.tapBackgroundDismissEnable = YES;
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
