//
//  MyAddressViewController.h
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;

@interface MyAddressViewController : UIViewController

@property (nonatomic, copy) void (^changeAddress)(AddressModel *addressModel);
@property (nonatomic, assign) BOOL isSelectAddress;

@end
