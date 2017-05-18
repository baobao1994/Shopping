//
//  OrderTableViewCell.m
//  Shopping
//
//  Created by 郭伟文 on 2017/5/17.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import "OrderTableViewCell.h"
#import "CartOrderModel.h"
#import "OrderModel.h"
#import "StitchingImage.h"

const CGFloat canvasViewSideLength = 45.0f;

@interface OrderTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *foodImageView;
@property (weak, nonatomic) IBOutlet UILabel *foodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation OrderTableViewCell

- (void)setContent:(OrderModel *)orderModel {
    NSString *foodName = @"";
    NSInteger orderCount = orderModel.orderList.count;
    for (int i = 0; i < orderCount; i ++) {
        CartOrderModel *cartOrderModel = orderModel.orderList[i];
        if (i == 1) {
            foodName = [NSString stringWithFormat:@"%@、%@",foodName,cartOrderModel.name];
            break;
        } else {
            foodName = [NSString stringWithFormat:@"%@",cartOrderModel.name];
        }
    }
    if (orderCount > 2) {
        foodName = [NSString stringWithFormat:@"%@、等%ld件食品",foodName,orderModel.orderList.count];
    } else {
        foodName = [NSString stringWithFormat:@"%@ %ld件食品",foodName,orderModel.orderList.count];
    }
    self.foodNameLabel.text = foodName;
    self.priceLabel.text = [NSString stringWithFormat:@"%@元",orderModel.price];
    [self createCanvasViews];
}

- (void)createCanvasViews {
    self.foodImageView.layer.cornerRadius = canvasViewSideLength / 10;
    self.foodImageView.layer.masksToBounds = YES;
    self.foodImageView.backgroundColor = [UIColor colorWithWhite:0.839 alpha:1.000];
    int imageViewsCount = 9;
    self.foodImageView = [self createImageViewWithCanvasView:self.foodImageView withImageViewsCount:imageViewsCount];
}

- (UIImageView *)createImageViewWithCanvasView:(UIImageView *)canvasView withImageViewsCount:(NSInteger)count {
    NSMutableArray *imageViews = [[NSMutableArray alloc] init];
    for (int index = 1; index <= count; index++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", index]];
        imageView.image = image;
        
        [imageViews addObject:imageView];
    }
    return [[StitchingImage alloc] stitchingOnImageView:canvasView withImageViews:imageViews];
}

@end
