//
//  PayOrderTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/4.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartOrderModel;

@interface PayOrderTableViewCell : UITableViewCell

- (void)setContent:(CartOrderModel *)CartOrderModel;

@end
