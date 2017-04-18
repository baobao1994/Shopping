//
//  MyTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyTableViewCell.h"
#import "MyModel.h"

@interface MyTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@end

@implementation MyTableViewCell

- (void)setContent:(MyModel *)myModel {
    self.itemImageView.image = [UIImage imageNamed:myModel.itemImageName];
    self.itemTitleLabel.text = myModel.itemTitleName;
}

@end
