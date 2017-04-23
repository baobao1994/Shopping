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
#import "UserInfoModel.h"

@interface MyHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@end

@implementation MyHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MyHeaderView" owner:self options:nil] firstObject];
        [self.userImageView setCornerRadius:self.userImageView.frame.size.width / 2];
    }
    return self;
}

- (void)setHeaderContent:(UserInfoModel *)userInfoModel replaceLocalImage:(UIImage *)localImage {
    if (userInfoModel == nil) {
        self.userNameLabel.text = @"请登录";
        self.userImageView.image = [UIImage imageNamed:@"default_logo"];
        self.balanceLabel.text = @"-";
        self.couponLabel.text = @"-";
        self.integralLabel.text = @"-";
    } else {
        self.userNameLabel.text = userInfoModel.userName;
        if (localImage) {
            self.userImageView.image = localImage;
        } else {
            [self.userImageView sd_setImageWithURL:[NSURL URLWithString:userInfoModel.userImageName] placeholderImage:[UIImage imageNamed:@"default_logo"]];
        }
        self.balanceLabel.text = [NSString stringWithFormat:@"%@元",userInfoModel.userBalance];
        self.couponLabel.text = [NSString stringWithFormat:@"%@个",userInfoModel.userCoupon];
        self.integralLabel.text = [NSString stringWithFormat:@"%@积分",userInfoModel.userIntegral];
    }
}

@end
