//
//  MyAddressTableViewCell.h
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;

@interface MyAddressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

- (void)setAddress:(AddressModel *)addressModel;

@end
