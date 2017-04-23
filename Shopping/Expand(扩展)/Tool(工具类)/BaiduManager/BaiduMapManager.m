//
//  BaiduMapManager.m
//  RoadRescueApp
//
//  Created by yh on 16/7/9.
//  Copyright © 2016年 cuicuiTech. All rights reserved.
//

#import "BaiduMapManager.h"
#import "ConstString.h"

@implementation BaiduMapManager

+ (BaiduMapManager *)shareInstance {
    static BaiduMapManager *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

-(void)startBaiduMap {
    BOOL ret = [self.mapManager start:BaiduMapKey generalDelegate:nil];
    if (!ret) {
        NSLog(@"百度地图启动失败");
    }
}

-(void)startLocation:(DidGetUserLocationBlock)getLocationCallBack {
    didGetUserLocationBlock = getLocationCallBack;
    self.locService.delegate = self;
    [self.locService startUserLocationService];
    self.isLocatingUser = YES;
}

//停止检测用户位置
-(void)stopLocation {
    if (self.locService) {
        [self.locService stopUserLocationService];
        self.isLocatingUser = NO;
    }
}

#pragma mark - class func

+(BMKMapView *)getMapViewInstance {
    BMKMapView* mapView = [[BMKMapView alloc] init];
    return mapView;
}

+(void)showMapViewCenter:(BMKMapView *)mapViewInstance CenterCordinate:(CLLocationCoordinate2D)centerCordinate {
    [mapViewInstance setCenterCoordinate:centerCordinate animated:NO];
//    BMKCoordinateRegion region ;//表示范围的结构体
//    region.center = centerCordinate;//中心点
//    region.span.latitudeDelta = 0.1;//经度范围（设置为0.1表示显示范围为0.2的纬度范围）
//    region.span.longitudeDelta = 0.1;//纬度范围
//
//    [mapViewInstance setRegion:region animated:YES];
}

+(BMKPointAnnotation *)showAnnotationInMapView:(BMKMapView *)mapViewInstance withCordinate:(CLLocationCoordinate2D)centerCordinate AnnotationTitle:(NSString *)annotationTitle {
    BMKPointAnnotation * annotation = [[BMKPointAnnotation alloc] init];
    annotation.coordinate = centerCordinate;
    annotation.title = annotationTitle;
    [mapViewInstance addAnnotation:annotation];
    return annotation;
}

//删除annotation
+(void)removeAllAnnotationFromMapView:(BMKMapView *)mapViewInstance {
    for (BMKPointAnnotation * annotation in mapViewInstance.annotations) {
        [mapViewInstance removeAnnotation:annotation];
    }
}

//获取关键词返回的信息
-(void)searchLoactionString:(NSString *)locationString withUserLocation:(CLLocationCoordinate2D) userLocation withResultCallBack:(DidSearchResultBlock)resultCallBack {
    didSearchResultBlock = resultCallBack;
    CLLocation * userCurrentLocation = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
    __weak typeof(self) weakSelf = self;
    [[self class] reverseGeocodeLocation:userCurrentLocation withReverseCallBack:^(NSString *placeName) {
        BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
        option.cityname = placeName;
        option.keyword  = locationString;
        BOOL flag = [weakSelf.searcher suggestionSearch:option];
        if(flag) {
//            resultCallBack(nil,NO);
            NSLog(@"建议检索发送成功");
        } else {
            didSearchResultBlock(nil,nil,NO);
            NSLog(@"建议检索发送失败");
        }
    }];
}

-(void)searchNearByString:(NSString *)nearByString withUserLocation:(CLLocationCoordinate2D) userLocation withResultCallBack:(DidPoiSearchResultBlock)resultCallBack {
    didPoiSearchResultBlock = resultCallBack;
    BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 100;
    option.location = userLocation;
    option.keyword = nearByString;
    BOOL flag = [self.poiSearcher poiSearchNearBy:option];
    if(flag) {
//        NSLog(@"周边检索发送成功");
    } else {
        [MBProgrossManagerInstance showOnlyText:@"检索失败，请重试" HudHiddenCallBack:nil];
    }
}

//反转义，
+(void)reverseGeocodeLocation:(CLLocation*)location withReverseCallBack:(void(^)(NSString * placeName))reverseCallBack {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0){
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            reverseCallBack(placemark.administrativeArea);
        }else if (error == nil && [placemarks count] == 0){  //无法获取位置 默认为福州
            reverseCallBack(@"福州");
        }
        else if (error != nil){
            reverseCallBack(@"福州");
        }
    }];
}

//计算亮点的实际具体
+(CLLocationDistance)getDistanceFromFirstCoor:(CLLocationCoordinate2D)firstCoor ToSecondPoint:(CLLocationCoordinate2D)secondCoor {
    BMKMapPoint point1 = BMKMapPointForCoordinate(firstCoor);
    BMKMapPoint point2 = BMKMapPointForCoordinate(secondCoor);
    return BMKMetersBetweenMapPoints(point1,point2);
}

#pragma mark - delegate
//定位成功回调
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    [self.locService stopUserLocationService];
    if (didGetUserLocationBlock != nil) {
        didGetUserLocationBlock(userLocation,self.locService,YES);
    }
}

//定位回调失败
- (void)didFailToLocateUserWithError:(NSError *)error {
    if (didGetUserLocationBlock != nil) {
        didGetUserLocationBlock(nil,nil,NO);
    }
}

//搜索关键词回调
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR){
        didSearchResultBlock(result.keyList,result.ptList,YES);
    }else{
        didSearchResultBlock(nil,nil,NO);
    }
}

//周边搜索回调
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        //在此处理正常结果
        if (didPoiSearchResultBlock) {
            didPoiSearchResultBlock(poiResultList,YES);
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
        // result.cityList;
        NSLog(@"起始点有歧义");
        if (didPoiSearchResultBlock) {
            didPoiSearchResultBlock(poiResultList,NO);
        }
    } else {
        NSLog(@"抱歉，未找到结果");
        if (didPoiSearchResultBlock) {
            didPoiSearchResultBlock(nil,NO);
        }
    }
}

#pragma mark - getter func

-(BMKMapManager *)mapManager {
    if (_mapManager == nil) {
        _mapManager = [[BMKMapManager alloc]init];
    }
    return _mapManager;
}

-(BMKLocationService *)locService {
    if (_locService == nil) {
        _locService = [[BMKLocationService alloc] init];
    }
    return _locService;
}

-(BMKUserLocation *)getCurrentUserLocation {
    return self.locService.userLocation;
}

-(BMKSuggestionSearch *)searcher {
    if (!_searcher) {
        _searcher = [[BMKSuggestionSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}

-(BMKPoiSearch *)poiSearcher{
    if (!_poiSearcher) {
        _poiSearcher = [[BMKPoiSearch alloc]init];
        _poiSearcher.delegate = self;
    }
    return _poiSearcher;
}

@end
