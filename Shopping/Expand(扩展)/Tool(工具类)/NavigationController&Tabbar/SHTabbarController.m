//
//  SHTabbarController.m
//  SHCW
//
//  Created by 郭伟文 on 16/12/7.
//  Copyright © 2016年 Baobao. All rights reserved.
//

#import "SHTabbarController.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "OrderViewController.h"
#import "SHNavigationController.h"
#import "UIImage+Addition.h"

@interface SHTabbarController ()

@end

@implementation SHTabbarController

+ (void)initialize {
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];

    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    
    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0] andSize:CGSizeMake(UIScreenWidth, 1)]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAllChildVc];
}

- (void)setUpAllChildVc {
    HomeViewController *HomeVC = [[HomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"tabbar_home_normal" selectedImage:@"tabbar_home_select" title:@"美食"];
    OrderViewController *OrderVC = [[OrderViewController alloc] init];
    [self setUpOneChildVcWithVc:OrderVC Image:@"tabbar_order_normal" selectedImage:@"tabbar_order_select" title:@"订单"];
    MyViewController *MyVC = [[MyViewController alloc] init];
    [self setUpOneChildVcWithVc:MyVC Image:@"tabbar_my_normal" selectedImage:@"tabbar_my_select" title:@"我的"];
}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    SHNavigationController *navigationController = [[SHNavigationController alloc] initWithRootViewController:Vc];
    Vc.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    Vc.tabBarItem.image = myImage;
    
    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    Vc.tabBarItem.selectedImage = mySelectedImage;
    Vc.tabBarItem.title = title;
    Vc.navigationItem.title = title;
    
    [self addChildViewController:navigationController];
}

@end
