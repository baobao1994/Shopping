//
//  MyAddressTableViewCell.m
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyAddressTableViewCell.h"
#import "AddressModel.h"

@interface MyAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telephoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation MyAddressTableViewCell

- (void)setAddress:(AddressModel *)addressModel {
    NSString *sex = addressModel.sex;
    if ([sex isEqualToString:@"male"]) {
        sex = @"(男士)";
    } else {
        sex = @"(女士)";
    }
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",addressModel.name,sex];
    self.telephoneLabel.text = addressModel.telephone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ - %@",addressModel.address,addressModel.detailAddress];
}

@end
