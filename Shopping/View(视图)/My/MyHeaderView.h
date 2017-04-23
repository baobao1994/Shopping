//
//  MyHeaderView.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/12.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserInfoModel;

@interface MyHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *changeUserLogoButton;

- (void)setHeaderContent:(UserInfoModel *)userInfoModel replaceLocalImage:(UIImage *)localImage;

@end
