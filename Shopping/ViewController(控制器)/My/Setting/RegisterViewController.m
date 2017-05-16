//
//  RegisterViewController.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "RegisterViewController.h"
#import "JVFloatLabeledTextField.h"
#import "TimeDownView.h"
#import "NSString+MD5.h"
#import "ConstString.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewHeightConstraint;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *telephoneTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *securityCodeTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *pwdTF;
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *surePwdTF;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (strong, nonatomic) TimeDownView *timeDownView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:self.telephoneTF];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"UITextFieldTextDidChangeNotification" object:nil];
}

- (void)setUp {
    WEAKSELF_SC;
    self.title = @"注册";
    self.timeDownView = [[TimeDownView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    self.timeDownView.timeButton.enabled = NO;
    [self.timeView addSubview:self.timeDownView];
    [self.timeDownView setDidCountDown:^{
        if (self.telephoneTF.text.length != 11) {
            [MBProgrossManagerInstance showErrorOnlyText:@"请输入11位手机号" HudHiddenCallBack:nil];
        } else {
            BmobQuery *query = [[BmobQuery alloc] initWithClassName:UserTable];
            [query whereKey:UserTelePhoneKey equalTo:weakSelf_SC.telephoneTF.text];
            [query countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                if (number >= 1) {
                    [MBProgrossManagerInstance showErrorOnlyText:@"该账号已经被注册" HudHiddenCallBack:nil];
                    weakSelf_SC.timeDownView.time = 0;
                } else {
                    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:weakSelf_SC.telephoneTF.text andTemplate:SMSModelNameKey resultBlock:^(int msgId, NSError *error) {
                        if (error) {
                            [MBProgrossManagerInstance showErrorOnlyText:@"发送失败，请检查网络" HudHiddenCallBack:nil];
                        } else {
                            [MBProgrossManagerInstance showSuccessOnlyText:@"发送成功，请查收" HudHiddenCallBack:nil];
                        }
                    }];
                }
            }];
        }
    }];
    self.contentViewWidthConstraint.constant = UIScreenWidth;
    self.contentViewHeightConstraint.constant = UIScreenHeight - 63;
    self.scrollView.contentSize = CGSizeMake(UIScreenWidth, UIScreenHeight);
}

- (void)textFiledEditChanged:(NSNotification *)notification {
    if (self.telephoneTF.text.length == 11) {
        self.timeDownView.timeButton.enabled = YES;
    } else {
        self.timeDownView.timeButton.enabled = NO;
    }
}

- (IBAction)didSelectRegisterBtn:(UIButton *)sender {
    if (self.telephoneTF.text.length != 11) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请输入11位手机号" HudHiddenCallBack:nil];
    } else if (self.securityCodeTF.text.length != 6) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请输入验证码" HudHiddenCallBack:nil];
    } else if (self.pwdTF.text.length > 16 || self.pwdTF.text.length < 8) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请输入密码" HudHiddenCallBack:nil];
    } else if (self.surePwdTF.text.length > 16 || self.surePwdTF.text.length < 8) {
        [MBProgrossManagerInstance showErrorOnlyText:@"请再输入密码" HudHiddenCallBack:nil];
    } else if (![self.pwdTF.text isEqualToString:self.surePwdTF.text]) {
        [MBProgrossManagerInstance showErrorOnlyText:@"两次密码不一致" HudHiddenCallBack:nil];
    } else {
        [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:self.telephoneTF.text andSMSCode:self.securityCodeTF.text resultBlock:^(BOOL isSuccessful, NSError *error) {
            if (isSuccessful) {
                BmobObject *user = [BmobObject objectWithClassName:UserTable];
                [user setObject:self.telephoneTF.text forKey:UserTelePhoneKey];
                [user setObject:@"新二货一枚" forKey:UserNameKey];
                [user setObject:[self.pwdTF.text md5HexDigest] forKey:UserPasswordKey];
                [user setObject:[NSNumber numberWithInt:0] forKey:UserBalanceKey];
                [user setObject:[NSNumber numberWithInt:0] forKey:UserCouponKey];
                [user setObject:[NSNumber numberWithInt:0] forKey:UserIntegralKey];
                [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    [MBProgrossManagerInstance showSuccessOnlyText:@"注册成功" HudHiddenCallBack:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                }];
            } else {
                [MBProgrossManagerInstance showErrorOnlyText:@"验证码错误，请重新输入" HudHiddenCallBack:nil];
            }
        }];
    }
}

- (IBAction)hideKeyBoard:(JVFloatLabeledTextField *)sender {
    [sender resignFirstResponder];
}

@end
