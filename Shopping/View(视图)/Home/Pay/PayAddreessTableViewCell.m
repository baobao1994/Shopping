//
//  PayAddreessTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "PayAddreessTableViewCell.h"
#import "AddressModel.h"

@interface PayAddreessTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation PayAddreessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContent:(AddressModel *)addressModel {
    if (addressModel) {
        NSString *sex = @"女士";
        if (addressModel.sex) {
            sex = @"男士";
        }
        self.nameLabel.text = [NSString stringWithFormat:@"%@ (%@)",addressModel.name,sex];
        self.telLabel.text = addressModel.telephone;
        self.addressLabel.text = [NSString stringWithFormat:@"地址:%@%@",addressModel.detailAddress,addressModel.address];
    }
}

@end
