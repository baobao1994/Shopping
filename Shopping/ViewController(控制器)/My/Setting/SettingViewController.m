//
//  SettingViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "SettingViewController.h"
#import "UITableViewCell+Addition.h"
#import "PersonInfoViewController.h"
#import "LoginViewController.h"
#import "AboutViewController.h"
#import "TableStaticViewCell.h"
#import "TableStaticModel.h"
#import "CATransition+Addition.h"
#import "SDImageCache.h"
#import "ConstString.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemArr;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initItemData];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 0.01)];
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
    NSInteger row = indexPath.row;
    if (row == 0) {
        [self clearCache];
    } else if (row == 1) {
        if (UserManagerInstance.userInfo) {
            PersonInfoViewController *personInfoVC = [[PersonInfoViewController alloc] init];
            [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
            [self.navigationController pushViewController:personInfoVC animated:NO];
        } else {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
            [self.navigationController pushViewController:loginVC animated:NO];
        }
    } else if (row == 2) {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
        [self.navigationController pushViewController:aboutVC animated:NO];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableStaticViewCell *cell = [TableStaticViewCell dequeOrCreateInTable:tableView selectedBackgroundViewColor:UIColorFromHexColor(0xccc2c2)];
    [cell setContent:_itemArr[indexPath.row]];
    return cell;
}

#pragma mark - Private Method

- (void)initItemData {
    self.itemArr = [[NSMutableArray alloc] init];
    NSArray *itemArr = @[@[@"integral_mall",@"清除图片缓存"],@[@"collect",@"个人信息"],@[@"address",@"关于我们"]];
    for (NSArray *arr in itemArr) {
        TableStaticModel *tableStaticModel = [[TableStaticModel alloc] init];
        tableStaticModel.itemImageName = arr[0];
        tableStaticModel.itemTitleName = arr[1];
        [self.itemArr addObject:tableStaticModel];
    }
    [self.tableView reloadData];
}

-(void)clearCache {
    NSString *cachePath = DOCUMENT_PATH;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            if ([fileName isEqualToString:LogoCache]) {
                NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:fileAbsolutePath error:nil];
            }
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

- (IBAction)didSelectOutLoginBtn:(UIButton *)sender {
    [UserManagerInstance deleteUser];
    [MBProgrossManagerInstance showSuccessOnlyText:@"退出成功" HudHiddenCallBack:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
