//
//  PlaceBubbleView.h
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceBubbleView : UIView

@property (nonatomic, copy) void (^didSurePlace)(void);
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
