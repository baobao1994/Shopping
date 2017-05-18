//
//  ShoopingCartTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/5/11.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CartOrderModel;

@interface ShoopingCartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cutButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *foodCountTF;

- (void)setContent:(CartOrderModel *)CartOrderModel;

@end
