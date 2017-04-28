//
//  SHNavigationController.m
//  SHCW
//
//  Created by 郭伟文 on 16/12/7.
//  Copyright © 2016年 Baobao. All rights reserved.
//

#import "SHNavigationController.h"
#import "UIImage+Addition.h"

@interface SHNavigationController ()

@end

@implementation SHNavigationController

+ (void)load {
    UIBarButtonItem *item=[UIBarButtonItem appearanceWhenContainedIn:self, nil ];
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    dic[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:dic forState:UIControlStateNormal];
    
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[self]];
    [bar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0] andSize:CGSizeMake(UIScreenWidth, 1)] forBarMetrics:UIBarMetricsDefault];
    bar.shadowImage = [UIImage imageWithColor:[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0] andSize:CGSizeMake(UIScreenWidth, 1)];
    NSMutableDictionary *dicBar=[NSMutableDictionary dictionary];
    dicBar[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [bar setTitleTextAttributes:dic];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    return [super pushViewController:viewController animated:animated];
}

@end
