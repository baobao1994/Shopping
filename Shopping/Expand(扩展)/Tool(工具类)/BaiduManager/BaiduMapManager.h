//
//  BaiduMapManager.h
//  RoadRescueApp
//
//  Created by yh on 16/7/9.
//  Copyright © 2016年 cuicuiTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduMapApiHeader.h"

typedef void (^DidGetUserLocationBlock)(BMKUserLocation * userLocation,BMKLocationService * locationService,BOOL getLocationSuccess);
typedef void (^DidSearchResultBlock)(NSArray * serchResultBlock,NSArray * searchCoorResult, BOOL searchSuccess);
typedef void (^DidPoiSearchResultBlock)(BMKPoiResult * poiResult, BOOL searchSuccess);

@interface BaiduMapManager : NSObject<BMKLocationServiceDelegate,BMKSuggestionSearchDelegate,BMKPoiSearchDelegate>{
    DidGetUserLocationBlock didGetUserLocationBlock;
    DidSearchResultBlock didSearchResultBlock;
    DidPoiSearchResultBlock didPoiSearchResultBlock;
}

@property(nonatomic,strong)BMKMapManager * mapManager;
@property(nonatomic,strong)BMKLocationService * locService;
//关键词搜索
@property (strong,nonatomic) BMKSuggestionSearch *searcher;
//周边搜索
@property(nonatomic,strong)BMKPoiSearch * poiSearcher;
/**
 *  是否正在检测用户当前位置
 */
@property(nonatomic,assign)BOOL isLocatingUser;

+ (BaiduMapManager *)shareInstance;

-(void)startBaiduMap;

-(BMKUserLocation *)getCurrentUserLocation;

/**
 *  初始化一个mapview
 *
 *  @return mapview
 */
+(BMKMapView *)getMapViewInstance;

/**
 *  监听当前位置
 *
 *  @param getLocationCallBack 回调
 */
-(void)startLocation:(DidGetUserLocationBlock)getLocationCallBack;

/**
 *  停止检测用户当前位置
 */
-(void)stopLocation;

/**
 *  设置地图中心点
 *
 *  @param mapViewInstance mapview实例
 *  @param centerCordinate 中心位置
 */
+(void)showMapViewCenter:(BMKMapView *)mapViewInstance CenterCordinate:(CLLocationCoordinate2D)centerCordinate;

/**
 *  增加地图标注
 *
 *  @param mapViewInstance 地图实例
 *  @param centerCordinate 标注的经纬度
 *  @param annotationTitle 标注的泡泡占海的
 *
 *  @return 
 */
+(BMKPointAnnotation *)showAnnotationInMapView:(BMKMapView *)mapViewInstance withCordinate:(CLLocationCoordinate2D)centerCordinate AnnotationTitle:(NSString *)annotationTitle;

//删除annotation
+(void)removeAllAnnotationFromMapView:(BMKMapView *)mapViewInstance;
/**
 *  搜索关键词
 *
 *  @param locationString 关键词
 *  @param userLocation   用户当前位置
 *  @param resultCallBack 
 */
-(void)searchLoactionString:(NSString *)locationString withUserLocation:(CLLocationCoordinate2D) userLocation withResultCallBack:(DidSearchResultBlock)resultCallBack;

//计算两点的实际距离,结果是米
+(CLLocationDistance)getDistanceFromFirstCoor:(CLLocationCoordinate2D)firstCoor ToSecondPoint:(CLLocationCoordinate2D)secondCoor;

/**
 周边搜索

 @param nearByString   搜索关键词
 @param userLocation   当前位置
 @param resultCallBack 
 */
-(void)searchNearByString:(NSString *)nearByString withUserLocation:(CLLocationCoordinate2D) userLocation withResultCallBack:(DidPoiSearchResultBlock)resultCallBack;

@end

