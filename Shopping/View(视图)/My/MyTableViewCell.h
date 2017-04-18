//
//  MyTableViewCell.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyModel;

@interface MyTableViewCell : UITableViewCell

- (void)setContent:(MyModel *)myModel;

@end
