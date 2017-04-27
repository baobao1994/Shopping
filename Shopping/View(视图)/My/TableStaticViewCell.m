//
//  MyTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "TableStaticViewCell.h"
#import "TableStaticModel.h"

@interface TableStaticViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@end

@implementation TableStaticViewCell

- (void)setContent:(TableStaticModel *)tableStaticModel {
    self.itemImageView.image = [UIImage imageNamed:tableStaticModel.itemImageName];
    self.itemTitleLabel.text = tableStaticModel.itemTitleName;
}

@end
