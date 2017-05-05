//
//  MyViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyViewController.h"
#import "UITableViewCell+Addition.h"
#import "MyAddressViewController.h"
#import "MyAddressViewController.h"
#import "PullToRefreshTableView.h"
#import "HXPhotoViewController.h"
#import "CATransition+Addition.h"
#import "SettingViewController.h"
#import "UIViewController+Pop.h"
#import "LoginViewController.h"
#import "TableStaticViewCell.h"
#import "TableStaticModel.h"
#import "SystemInfoModel.h"
#import "UserInfoModel.h"
#import "MyHeaderView.h"
#import "MyFooterview.h"
#import "ConstString.h"
#import "Toast.h"

@interface MyViewController () <PullToRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource,HXPhotoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshTableView *tableView;
@property (nonatomic, strong) MyHeaderView *myHeaderView;
@property (nonatomic, strong) MyFooterview *myFooterview;
@property (nonatomic, strong) NSMutableArray *itemArr;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (nonatomic, strong) UIImage *userImage;
@property (nonatomic, strong) UserInfoModel *userInfoModel;
@property (nonatomic, strong) SystemInfoModel *systemInfoModel;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.customTableDelegate = self;
    [_tableView setRefreshCategory:DropdownRefresh];
    [self createNavigationRightItem:@"setting"];
    [self initItemData];
    [self initPhoto];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (UserManagerInstance.userInfo.userObjectId) {
        self.userInfoModel = UserManagerInstance.userInfo;
        self.systemInfoModel = UserManagerInstance.systemInfo;
    } else {
        self.userImage = nil;
    }
    [self reloadList];
    [self.tableView reloadData];
}

- (void)selectedNavigationRightItem:(id)sender {
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

#pragma mark - PullToRefreshTableViewDelegate method

- (void)getHeaderDataSoure {
    if (UserManagerInstance.userInfo.userObjectId) {
        [self reloadList];
    } else {
        [self pushLoginViewController];
        [self.tableView doneLoadingTableViewData];
    }
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
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 210.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!_myHeaderView) {
        _myHeaderView = [[MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 150)];
        [_myHeaderView.changeUserLogoButton addTarget:self action:@selector(didSelectChangeUserLogoBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    [_myHeaderView setHeaderContent:self.userInfoModel replaceLocalImage:self.userImage];
    return _myHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (!_myFooterview) {
        _myFooterview = [[MyFooterview alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 40)];
    }
    if (_systemInfoModel.isOpen) {
        _myFooterview.titleLabel.text = [NSString stringWithFormat:@"营业时间:%@\n客服热线:%@",_systemInfoModel.openTime,_systemInfoModel.serviceTel];
    } else {
        _myFooterview.titleLabel.text = @"今天店家休息暂不营业！";
    }
    return _myFooterview;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (UserManagerInstance.userInfo.userObjectId) {
        NSInteger row = indexPath.row;
        if (row == 0) {
            
        } else if (row == 1) {
            
        } else if (row == 2) {
            [self pushMyAddressViewController];
        }
    } else {
        [self pushLoginViewController];
        [self pushMyAddressViewController];
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

- (void)pushLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)pushMyAddressViewController {
    MyAddressViewController *loginVC = [[MyAddressViewController alloc] init];
    [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)reloadList {
    BmobQuery *userQuery = [BmobQuery queryWithClassName:UserTable];
    [userQuery getObjectInBackgroundWithId:_userInfoModel.userObjectId block:^(BmobObject *object, NSError *error) {
        BOOL isRemeber = self.userInfoModel.isRemember;
        self.userInfoModel = [[UserInfoModel alloc] initWithDictionary:(NSDictionary *)object];
        self.userInfoModel.isRemember = isRemeber;
        [UserManagerInstance saveUserInfo:self.userInfoModel];
        [_tableView doneLoadingTableViewData];
        [_tableView reloadData];
    }];
    BmobQuery *systemQuery = [BmobQuery queryWithClassName:SystemTable];
    [systemQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count) {
            self.systemInfoModel = [[SystemInfoModel alloc] initWithDictionary:(NSDictionary *)array[0]];
            [UserManagerInstance saveSystemInfo:self.systemInfoModel];
            [_tableView doneLoadingTableViewData];
            [_tableView reloadData];
        }
    }];
}

- (void)initItemData {
    self.itemArr = [[NSMutableArray alloc] init];
    NSArray *itemArr = @[@[@"integral_mall",@"积分商城"],@[@"collect",@"我的收藏"],@[@"address",@"我的地址"]];
    for (NSArray *arr in itemArr) {
        TableStaticModel *tableStaticModel = [[TableStaticModel alloc] init];
        tableStaticModel.itemImageName = arr[0];
        tableStaticModel.itemTitleName = arr[1];
        [self.itemArr addObject:tableStaticModel];
    }
    [self.tableView reloadData];
}

- (void)initPhoto {
    _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
    _manager.videoMaxNum = 0;
    _manager.openCamera = YES;
    _manager.maxNum = 1;
    _manager.photoMaxNum = 1;
    _manager.selectTogether = NO;
}

#pragma mark - didSelectBtn

- (void)didSelectChangeUserLogoBtn:(UIButton *)sender {
    if (UserManagerInstance.userInfo.isRemember) {
        HXPhotoViewController *photoVC = [[HXPhotoViewController alloc] init];
        photoVC.delegate = self;
        photoVC.manager = self.manager;
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:photoVC] animated:YES completion:nil];
    } else {
        [self pushLoginViewController];
    }
}

#pragma mark - HXPhotoViewControllerDelegate

- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original {
    if (photos.count) {
        HXPhotoModel *photoModel = photos[0];
        self.userImage = photoModel.thumbPhoto;
        NSString *path_sandox = DOCUMENT_PATH;
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:[NSString stringWithFormat:@"/%@",LogoCache]];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(photoModel.thumbPhoto) writeToFile:imagePath atomically:YES];
        //添加图片上去
        BmobFile *imageFile = [[BmobFile alloc] initWithFilePath:imagePath];
        [imageFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                BmobObject *obj = [BmobObject objectWithoutDataWithClassName:UserTable objectId:self.userInfoModel.userObjectId];
                [obj setObject:imageFile.url forKey:UserImageNameKey];
                    [obj updateInBackground];
                [MBProgrossManagerInstance showSuccessOnlyText:@"更换头像成功" HudHiddenCallBack:^{
                    [self getHeaderDataSoure];
                }];
            } else {
                [MBProgrossManagerInstance showErrorOnlyText:@"更换头像失败,请重试" HudHiddenCallBack:nil];
            }
        }];
    }
}

- (void)photoViewControllerDidCancel {
    [[Toast makeText:@"您已取消更换头像"] show];
}

@end
