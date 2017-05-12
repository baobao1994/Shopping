//
//  PayAddreessTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddressModel;

@interface PayAddreessTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *inTheShopButton;
@property (weak, nonatomic) IBOutlet UIButton *outTheShopButton;
@property (weak, nonatomic) IBOutlet UIButton *changeAddressButton;

- (void)setContent:(AddressModel *)addressModel;

@end
