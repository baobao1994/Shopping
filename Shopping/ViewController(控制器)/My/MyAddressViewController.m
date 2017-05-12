//
//  MyAddressViewController.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyAddressViewController.h"
#import "UITableViewCell+Addition.h"
#import "MyAddressTableViewCell.h"
#import "SearchPlaceViewController.h"
#import "AddressModel.h"
#import "MBProgrossManager.h"
#import "EditAddressViewController.h"
#import "ConstString.h"
#import "UserInfoModel.h"

@interface MyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *myAddressArr;
@property (nonatomic, strong) EditAddressViewController *editAddressVC;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的地址";
    if (self.isSelectAddress) {
        self.tableView.allowsSelection = YES;
    }
    self.editAddressVC = [[EditAddressViewController alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.myAddressArr) {
        self.myAddressArr = [[NSMutableArray alloc] init];
    }
    BmobQuery *bquery = [BmobQuery queryWithClassName:AddressTable];
    [bquery whereKey:UserObjectIdKey equalTo:UserManagerInstance.userInfo.userObjectId];
    [bquery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.myAddressArr removeAllObjects];
        for (BmobObject *obj in array) {
            AddressModel *addreModel = [[AddressModel alloc] initWithDictionary:(NSDictionary *)obj];
            [self.myAddressArr addObject:addreModel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.changeAddress(self.myAddressArr[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.myAddressArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddressTableViewCell * cell = [MyAddressTableViewCell dequeInTable:tableView];
    if (!cell) {
        cell = [MyAddressTableViewCell loadFromNib];;
        [cell.editButton addTarget:self action:@selector(didSelectEditBtn:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(didSelectDeleteBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    cell.editButton.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    [cell setAddress:self.myAddressArr[indexPath.row]];
    return cell;
}

#pragma mark - Private Method

- (void)didSelectEditBtn:(UIButton *)sender {
    AddressModel *model = self.myAddressArr[sender.tag];
    EditAddressViewController *editAddressVC = [[EditAddressViewController alloc] init];
    editAddressVC.isEdit = YES;
    editAddressVC.addressModel = model;
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

- (void)didSelectDeleteBtn:(UIButton *)sender {
    AddressModel *model = self.myAddressArr[sender.tag];
    NSString *address = [NSString stringWithFormat:@"%@\n%@",model.detailAddress,model.address];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"删除该地址" message:address preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *certainAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.myAddressArr removeObjectAtIndex:sender.tag];
        [self.tableView reloadData];
        [[MBProgrossManager shareInstance] showOnlyText:@"删除成功" HudHiddenCallBack:^{
            
        }];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:certainAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)didSelectAddNewAddressBtn:(UIButton *)sender {
    EditAddressViewController *editAddressVC = [[EditAddressViewController alloc] init];
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

@end
