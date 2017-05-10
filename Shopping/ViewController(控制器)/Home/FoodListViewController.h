//
//  FoodListViewController.h
//  Shopping
//
//  Created by 郭伟文 on 2017/4/28.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CenterTableViewType) {
    CenterTableViewTopic,//一个个小的
    CenterTableViewGoods,//一整个大的
};

@interface FoodListViewController : UIViewController

@property (nonatomic, copy) NSString *foodTypeId;
@property (nonatomic, assign) CenterTableViewType type;

@end
