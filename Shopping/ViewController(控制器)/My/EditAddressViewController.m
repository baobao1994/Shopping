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
        [self.detailAddressButton setTitle:self.addressModel.address forState:UIControlStateNormal];
        self.addressTF.text = self.addressModel.detailAddress;
    } else {
        self.title = @"新增地址";
        [self.sureButton setTitle:@"新增地址" forState:UIControlStateNormal];
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
    }];
    [self.navigationController pushViewController:searchPlaceVC animated:YES];
}

- (IBAction)didSelectSureBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
