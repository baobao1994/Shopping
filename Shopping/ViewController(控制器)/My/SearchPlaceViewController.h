//
//  SearchPlaceViewController.h
//  Shopping
//
//  Created by baobao on 2017/4/22.
//  Copyright © 2017年 Baobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMapManager.h"

@interface SearchPlaceViewController : UIViewController

@property (nonatomic, copy) void (^didSelectedPlace)(BMKPoiInfo *);
@property (nonatomic, copy) NSString *selectedPlaceName;
@property (nonatomic, assign) CLLocationDegrees latitude;
@property (nonatomic, assign) CLLocationDegrees longitude;

@end
