//
//  MyHeaderView.m
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "MyHeaderView.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+Addition.h"

@interface MyHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] firstObject];
        [self.userImageView setCornerRadius:self.userImageView.frame.size.width / 2];
    }
    return self;
}

@end
