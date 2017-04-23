//
//  EditAddressViewController.h
//  Shopping
//
//  Created by baobao on 2017/4/23.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;

@interface EditAddressViewController : UIViewController

@property (nonatomic, assign) BOOL isEdit;//1:编辑,0:添加
@property (nonatomic, strong) AddressModel *addressModel;

@end
