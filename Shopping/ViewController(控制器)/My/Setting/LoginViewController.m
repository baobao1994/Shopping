//
//  LoginViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "JVFloatLabeledTextField.h"
#import "NSString+MD5.h"
#import "UserInfoModel.h"
#import "ConstString.h"
#import "MBProgressHUD+ND.h"
#import "JPUSHService.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telephoneTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pwdTF;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;
@property (nonatomic, strong) UserInfoModel *userInfoModel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.userInfoModel = UserManagerInstance.userInfo;
    if (self.userInfoModel) {
        if (self.userInfoModel.isRemember) {
            self.rememberSwitch.on = YES;
        } else {
            self.rememberSwitch.on = NO;
        }
    }
    self.contentViewWidthConstraint.constant = UIScreenWidth;
    self.contentViewHeightConstraint.constant = UIScreenHeight - 63;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth, UIScreenHeight);
}

- (IBAction)didSelectLoginBtn:(UIButton *)sender {
    if (self.telephoneTF.text.length == 0) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请输入手机号" HudHiddenCallBack:nil];
    } else if (self.pwdTF.text.length == 0) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请输入密码" HudHiddenCallBack:nil];
    } else {
        BmobQuery *bquery = [BmobQuery queryWithClassName:UserTable];
        [bquery whereKey:UserTelePhoneKey equalTo:self.telephoneTF.text];
        [bquery whereKey:UserPasswordKey equalTo:[self.pwdTF.text md5HexDigest]];
        [bquery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
            if (number) {
                [MBProgrossManagerInstance showSuccessOnlyText:@"登录成功" HudHiddenCallBack:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            } else {
                [MBProgrossManagerInstance showErrorOnlyText:@"账号密码错误" HudHiddenCallBack:nil];
            }
        }];
        [bquery calcInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (array.count) {
                [UserManagerInstance deleteUser];
                self.userInfoModel = [[UserInfoModel alloc] initWithDictionary:array[0]];
                self.userInfoModel.isRemember = self.rememberSwitch.isOn;
                [UserManagerInstance saveUserInfo:self.userInfoModel];
                [JPUSHService setAlias:self.userInfoModel.userObjectId callbackSelector:nil object:nil];
            }
        }];
    }
}

- (IBAction)didSelectPushRegisterVCBtn:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)didSelectForgetPwdVCBtn:(UIButton *)sender {
    ForgetPwdViewController *forgetPwdVC = [[ForgetPwdViewController alloc] init];
    [self.navigationController pushViewController:forgetPwdVC animated:YES];
}

- (IBAction)hideKeyBoard:(JVFloatLabeledTextField *)sender {
    [sender resignFirstResponder];
}

@end
