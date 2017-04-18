//
//  MyViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyViewController.h"
#import "UITableViewCell+Addition.h"
#import "PullToRefreshTableView.h"
#import "HXPhotoViewController.h"
#import "CATransition+Addition.h"
#import "LoginViewController.h"
#import "MyTableViewCell.h"
#import "UserInfoModel.h"
#import "MyHeaderView.h"
#import "MyFooterview.h"
#import "UserManager.h"
#import "MyModel.h"
#import "Toast.h"

@interface MyViewController () <PullToRefreshTableViewDelegate,UITableViewDelegate,UITableViewDataSource,HXPhotoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet PullToRefreshTableView *tableView;
@property (nonatomic, strong) MyHeaderView *myHeaderView;
@property (nonatomic, strong) MyFooterview *myFooterview;
@property (nonatomic, strong) NSMutableArray *itemArr;
@property (strong, nonatomic) HXPhotoManager *manager;
@property (nonatomic, strong) UIImage *userImage;
@property (nonatomic, strong) UserManager *userManager;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.customTableDelegate = self;
    [_tableView setRefreshCategory:NoRefresh];
    _userManager = [UserManager shareInstance];
    [self initItemData];
    [self initPhoto];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    return _myHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (!_myFooterview) {
        _myFooterview = [[MyFooterview alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, 40)];
    }
    return _myFooterview;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_userManager.userInfo) {
        
    } else {
        [self pushLoginViewController];
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
    MyTableViewCell *cell = [MyTableViewCell dequeOrCreateInTable:tableView selectedBackgroundViewColor:UIColorFromHexColor(0xccc2c2)];
    [cell setContent:_itemArr[indexPath.row]];
    return cell;
}

#pragma mark - Private Method

- (void)pushLoginViewController {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    [CATransition setAnimationType:@"rippleEffect" duration:0.5 subtype:-1];
    [self.navigationController pushViewController:loginVC animated:NO];
}

- (void)reloadList {
    [_tableView hideLoadedAllDataView];
}

- (void)initItemData {
    self.itemArr = [[NSMutableArray alloc] init];
    NSArray *itemArr = @[@[@"integral_mall",@"积分商城"],@[@"collect",@"我的收藏"],@[@"collect",@"我的地址"]];
    for (NSArray *arr in itemArr) {
        MyModel *myModel = [[MyModel alloc] init];
        myModel.itemImageName = arr[0];
        myModel.itemTitleName = arr[1];
        [self.itemArr addObject:myModel];
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
    HXPhotoViewController *photoVC = [[HXPhotoViewController alloc] init];
    photoVC.delegate = self;
    photoVC.manager = self.manager;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:photoVC] animated:YES completion:nil];
}

#pragma mark - HXPhotoViewControllerDelegate

- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original {
    if (photos.count) {
        [[Toast makeText:@"更换头像成功"] show];
        HXPhotoModel *photoModel = photos[0];
        self.myHeaderView.userImageView.image = photoModel.thumbPhoto;
        NSString *path_sandox = NSHomeDirectory();
        //设置一个图片的存储路径
        NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/logo.png"];
        //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
        [UIImagePNGRepresentation(photoModel.thumbPhoto) writeToFile:imagePath atomically:YES];
        //添加图片上去
        BmobFile *imageFile = [[BmobFile alloc] initWithFilePath:imagePath];
        [imageFile saveInBackground:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
//                BmobObject *obj = [[BmobObject alloc] initWithClassName:@"_User"];
//                [obj setObject:imageFile.url forKey:@"userImageUrl"];
//                if (self.userImage) {
//                    [obj updateInBackground];
//                } else {
//                    [obj saveInBackground];
//                }
            } else {
//                [[Toast makeText:@"更换头像失败"] show];
            }
        }];
    }
}

- (void)photoViewControllerDidCancel {
    [[Toast makeText:@"您已取消更换头像"] show];
}

@end
