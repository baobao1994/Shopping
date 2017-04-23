//
//  PlaceView.h
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMKPoiInfo;

@interface PlaceView : UIView

@property (nonatomic, copy) void (^didSelectPlace)(BMKPoiInfo *);

- (void)setPlacePoiInfoArr:(NSArray *)placeArr;

@end
