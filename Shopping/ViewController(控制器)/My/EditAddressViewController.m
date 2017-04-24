//
//  EditAddressViewController.m
//  Shopping
//
//  Created by baobao on 2017/4/23.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "EditAddressViewController.h"
#import "JVFloatLabeledTextField.h"
#import "SearchPlaceViewController.h"
#import "AddressModel.h"
#import "ConstString.h"
#import "UserManager.h"
#import "UserInfoModel.h"

@interface EditAddressViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *maleButton;
@property (weak, nonatomic) IBOutlet UIButton *femaleButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telephoneTF;
@property (weak, nonatomic) IBOutlet UIButton *detailAddressButton;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end

@implementation EditAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - Private Method

- (void)setUp {
    if (self.isEdit) {
        self.title = @"编辑地址";
        [self.sureButton setTitle:@"确认修改" forState:UIControlStateNormal];
        self.nameTF.text = self.addressModel.name;
        if ([self.addressModel.sex isEqualToString:@"male"]) {
            self.maleButton.selected = YES;
        } else {
            self.femaleButton.selected = YES;
        }
        self.telephoneTF.text = self.addressModel.telephone;
        [self.detailAddressButton setTitle:self.addressModel.detailAddress forState:UIControlStateNormal];
        self.addressTF.text = self.addressModel.address;
        self.detailAddressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else {
        self.title = @"新增地址";
        [self.sureButton setTitle:@"新增地址" forState:UIControlStateNormal];
        self.addressModel = [[AddressModel alloc] init];
    }
    self.contentViewWidthConstraint.constant = UIScreenWidth;
    self.contentViewHeightConstraint.constant = UIScreenHeight - 63;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth, UIScreenHeight);
}

- (IBAction)didSelectDetailAddressBtn:(UIButton *)sender {
    WEAKSELF_SC;
    SearchPlaceViewController *searchPlaceVC = [[SearchPlaceViewController alloc] init];
    [searchPlaceVC setDidSelectedPlace:^(BMKPoiInfo *poiInfo){
        weakSelf_SC.addressTF.text = poiInfo.name;
        [weakSelf_SC.detailAddressButton setTitle:poiInfo.address forState:UIControlStateNormal];
        self.detailAddressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        weakSelf_SC.addressModel.longitude = [NSNumber numberWithDouble:poiInfo.pt.longitude];
        weakSelf_SC.addressModel.latitude = [NSNumber numberWithDouble:poiInfo.pt.latitude];
    }];
    [self.navigationController pushViewController:searchPlaceVC animated:YES];
}

- (IBAction)didSelectSureBtn:(UIButton *)sender {
    if (self.nameTF.text.length == 0) {
        [MBProgrossManagerInstance showErrorOnlyText:@"姓名不能为空" HudHiddenCallBack:nil];
    } else if (self.telephoneTF.text.length == 0) {
        [MBProgrossManagerInstance showErrorOnlyText:@"电话不能为空" HudHiddenCallBack:nil];
    } else if ([self.detailAddressButton.titleLabel.text isEqualToString:@"点击设置"]) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请设置街道" HudHiddenCallBack:nil];
    } else {
        if (self.isEdit) {
            BmobQuery *query = [[BmobQuery alloc] initWithClassName:AddressTable];
            [query whereKey:ObjectIdKey equalTo:self.addressModel.objectId];
            [query calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
                if (!error) {
                    UserInfoModel *userInfoModel = [[UserInfoModel alloc] initWithDictionary:(NSDictionary *)array[0]];
                    BmobObject *obj = [BmobObject objectWithoutDataWithClassName:UserTable objectId:userInfoModel.userObjectId];
                    [obj setObject:self.telephoneTF.text forKey:UserTelePhoneKey];
                    [obj setObject:self.nameTF.text forKey:UserNameKey];
                    [obj setObject:self.detailAddressButton.titleLabel.text forKey:UserDetailAddressKey];
                    [obj setObject:self.addressTF.text forKey:UserAddressKey];
                    if (self.maleButton.selected) {
                        [obj setObject:@"male" forKey:UserSexKey];
                    } else {
                        [obj setObject:@"female" forKey:UserSexKey];
                    }
                    [obj setObject:self.addressModel.latitude forKey:AddressLatitudeKey];
                    [obj setObject:self.addressModel.longitude forKey:AddressLongitudeKey];
                    [obj setObject:UserManagerInstance.userInfo.userObjectId forKey:UserObjectIdKey];
                    [obj updateInBackground];
                    [MBProgrossManagerInstance showSuccessOnlyText:@"修改成功" HudHiddenCallBack:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [MBProgrossManagerInstance showErrorOnlyText:@"请检查网络" HudHiddenCallBack:nil];
                }
            }];
        } else {
            BmobObject *user = [BmobObject objectWithClassName:AddressTable];
            [user setObject:self.telephoneTF.text forKey:UserTelePhoneKey];
            [user setObject:self.nameTF.text forKey:UserNameKey];
            [user setObject:self.detailAddressButton.titleLabel.text forKey:UserDetailAddressKey];
            [user setObject:self.addressTF.text forKey:UserAddressKey];
            if (self.maleButton.selected) {
                [user setObject:@"male" forKey:UserSexKey];
            } else {
                [user setObject:@"female" forKey:UserSexKey];
            }
            [user setObject:self.addressModel.latitude forKey:AddressLatitudeKey];
            [user setObject:self.addressModel.longitude forKey:AddressLongitudeKey];
            [user setObject:UserManagerInstance.userInfo.userObjectId forKey:UserObjectIdKey];
            [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (!error) {
                    [MBProgrossManagerInstance showSuccessOnlyText:@"添加成功" HudHiddenCallBack:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                } else {
                    [MBProgrossManagerInstance showErrorOnlyText:@"请检查网络" HudHiddenCallBack:nil];
                }
            }];
        }
    }
}

- (IBAction)didSelectSexBtn:(UIButton *)sender {
    sender.selected = YES;
    if (sender.tag == 0) {
        self.femaleButton.selected = NO;
    } else {
        self.maleButton.selected = NO;
    }
}

- (IBAction)hideKeyBoard:(JVFloatLabeledTextField *)sender {
    [sender resignFirstResponder];
}

- (IBAction)didSelectHideKeyBoardBtn:(UIButton *)sender {
    [self.view endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
