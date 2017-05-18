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
#import "ConstString.h"
#import "UserInfoModel.h"
#import "GetNSDictionary.h"
#import "LoginViewController.h"
#import "Toast.h"

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
    if (UserManagerInstance.userInfo.userObjectId) {
        ScottAlertView *alertView = [ScottAlertView alertViewWithTitle:@"支付渠道" message:@""];
        [alertView addAction:[ScottAlertAction actionWithTitle:@"余额支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
            [self toPay];
        }]];
        
        [alertView addAction:[ScottAlertAction actionWithTitle:@"微信支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
            NSLog(@"%@",action.title);
        }]];
        
        [alertView addAction:[ScottAlertAction actionWithTitle:@"支付宝支付" style:ScottAlertActionStyleDefault handler:^(ScottAlertAction *action) {
            NSLog(@"%@",action.title);
        }]];
        
        [alertView addAction:[ScottAlertAction actionWithTitle:@"取消" style:ScottAlertActionStyleCancel handler:^(ScottAlertAction *action) {
            NSLog(@"%@",action.title);
        }]];
        
        ScottAlertViewController *alertController = [ScottAlertViewController alertControllerWithAlertView:alertView preferredStyle:ScottAlertControllerStyleActionSheet];
        alertController.tapBackgroundDismissEnable = YES;
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        [self pushLoginViewController];
    }
}

- (void)toPay {
    float balance = [UserManagerInstance.userInfo.userBalance floatValue] - [OrderManagerInstance calculatePrice:self.orderList];    if (balance >= 0) {
        BmobObject *orderQuery = [BmobObject objectWithClassName:OrderTable];
        [orderQuery setObject:[NSNumber numberWithBool:NO] forKey:OrderIsEvaluateKey];
        [orderQuery setObject:@"未完成" forKey:OrderStatusKey];
        [orderQuery setObject:UserManagerInstance.userInfo.userObjectId forKey:UserObjectIdKey];
        [orderQuery setObject:[NSString stringWithFormat:@"%.2f",[OrderManagerInstance calculatePrice:self.orderList]] forKey:OrderPriceKey];
        NSMutableArray *orderList = [[NSMutableArray alloc] init];
        for (CartOrderModel *cartOrderModel in self.orderList) {
            NSDictionary *dic = [GetNSDictionary getObjectData:cartOrderModel];
            [orderList addObject:dic];
        }
        [orderQuery setObject:orderList forKey:OrderListKey];
        [orderQuery saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
            if (!error) {
                BmobQuery *userQuery = [[BmobQuery alloc] initWithClassName:UserTable];
                [userQuery whereKey:ObjectIdKey equalTo:UserManagerInstance.userInfo.userObjectId];
                [userQuery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                    UserInfoModel *userInfoModel = [[UserInfoModel alloc] initWithDictionary:(NSDictionary *)array[0]];
                    userInfoModel.userBalance = [NSNumber numberWithFloat:balance];
                    [UserManagerInstance saveUserInfo:userInfoModel];
                    BmobObject *obj = [BmobObject objectWithoutDataWithClassName:UserTable objectId:userInfoModel.userObjectId];
                    [obj setObject:userInfoModel.userBalance forKey:UserBalanceKey];
                    [obj updateInBackground];
                }];
                [MBProgrossManagerInstance showSuccessOnlyText:@"下单成功" HudHiddenCallBack:^{
                    self.tabBarController.selectedIndex = 1;
                    [self.navigationController popToRootViewControllerAnimated:NO];
                }];
            } else {
                [MBProgrossManagerInstance showErrorOnlyText:@"请检查网络" HudHiddenCallBack:nil];
            }
        }];
    } else {
        [MBProgrossManagerInstance showOnlyText:@"余额不足,请充值或选择其它方式支付" HudHiddenCallBack:^{
            
        }];
    }
}

- (void)pushLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

@end
