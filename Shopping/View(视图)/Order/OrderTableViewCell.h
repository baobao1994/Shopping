//
//  OrderTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/17.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderModel;

@interface OrderTableViewCell : UITableViewCell

- (void)setContent:(OrderModel *)orderModel;

@end
